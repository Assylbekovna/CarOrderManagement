#!/bin/bash


dotnet new console -o TaxiOrderSystem
cd TaxiOrderSystem


mkdir States

cat > States/BaseState.cs <<'EOF'
namespace TaxiOrderSystem.States
{
    public abstract class BaseState
    {
        protected TaxiOrderContext _context;
        public void SetContext(TaxiOrderContext context) { _context = context; }
        public abstract void SelectCar();
        public abstract void ConfirmOrder();
        public abstract void CarArrived();
        public abstract void StartTrip();
        public abstract void CompleteTrip();
        public abstract void CancelOrder();
    }
}
EOF


cat > States/IdleState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class IdleState : BaseState
    {
        public override void SelectCar() { Console.WriteLine("Автомобиль выбран."); _context.TransitionTo(new CarSelectedState()); }
        public override void ConfirmOrder() => Console.WriteLine("Сначала выберите автомобиль.");
        public override void CarArrived() => Console.WriteLine("Автомобиль еще не заказан.");
        public override void StartTrip() => Console.WriteLine("Поездка не может начаться.");
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() => Console.WriteLine("Заказ отсутствует.");
    }
}
EOF


cat > States/CarSelectedState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class CarSelectedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Автомобиль уже выбран.");
        public override void ConfirmOrder() { Console.WriteLine("Заказ подтвержден, автомобиль в пути."); _context.TransitionTo(new OrderConfirmedState()); }
        public override void CarArrived() => Console.WriteLine("Автомобиль еще не в пути.");
        public override void StartTrip() => Console.WriteLine("Поездка не началась.");
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() { Console.WriteLine("Заказ отменен."); _context.TransitionTo(new TripCancelledState()); }
    }
}
EOF


cat > States/OrderConfirmedState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class OrderConfirmedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Автомобиль уже выбран.");
        public override void ConfirmOrder() => Console.WriteLine("Заказ уже подтвержден.");
        public override void CarArrived() { Console.WriteLine("Автомобиль прибыл."); _context.TransitionTo(new CarArrivedState()); }
        public override void StartTrip() => Console.WriteLine("Поездка еще не началась.");
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() { Console.WriteLine("Заказ отменен."); _context.TransitionTo(new TripCancelledState()); }
    }
}
EOF


cat > States/CarArrivedState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class CarArrivedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Автомобиль уже выбран.");
        public override void ConfirmOrder() => Console.WriteLine("Заказ уже подтвержден.");
        public override void CarArrived() => Console.WriteLine("Автомобиль уже прибыл.");
        public override void StartTrip() { Console.WriteLine("Поездка началась."); _context.TransitionTo(new InTripState()); }
        public override void CompleteTrip() => Console.WriteLine("Поездка не началась.");
        public override void CancelOrder() { Console.WriteLine("Заказ отменен."); _context.TransitionTo(new TripCancelledState()); }
    }
}
EOF


cat > States/InTripState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class InTripState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Поездка уже в процессе.");
        public override void ConfirmOrder() => Console.WriteLine("Поездка уже в процессе.");
        public override void CarArrived() => Console.WriteLine("Вы уже в машине.");
        public override void StartTrip() => Console.WriteLine("Поездка уже началась.");
        public override void CompleteTrip() { Console.WriteLine("Поездка завершена, ожидается оплата."); _context.TransitionTo(new TripCompletedState()); }
        public override void CancelOrder() { Console.WriteLine("Поездка отменена."); _context.TransitionTo(new TripCancelledState()); }
    }
}
EOF


cat > States/TripCompletedState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class TripCompletedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Поездка завершена.");
        public override void ConfirmOrder() => Console.WriteLine("Поездка завершена.");
        public override void CarArrived() => Console.WriteLine("Поездка завершена.");
        public override void StartTrip() => Console.WriteLine("Поездка завершена.");
        public override void CompleteTrip() => Console.WriteLine("Поездка уже завершена.");
        public override void CancelOrder() => Console.WriteLine("Поездка завершена, отмена невозможна.");
    }
}
EOF


cat > States/TripCancelledState.cs <<'EOF'
using System;
namespace TaxiOrderSystem.States
{
    public class TripCancelledState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Заказ отменен.");
        public override void ConfirmOrder() => Console.WriteLine("Заказ отменен.");
        public override void CarArrived() => Console.WriteLine("Заказ отменен.");
        public override void StartTrip() => Console.WriteLine("Заказ отменен.");
        public override void CompleteTrip() => Console.WriteLine("Заказ отменен.");
        public override void CancelOrder() => Console.WriteLine("Заказ уже отменен.");
    }
}
EOF


cat > TaxiOrderContext.cs <<'EOF'
using TaxiOrderSystem.States;
namespace TaxiOrderSystem
{
    public class TaxiOrderContext
    {
        private BaseState _state;
        public TaxiOrderContext(BaseState state) { TransitionTo(state); }
        public void TransitionTo(BaseState state) { _state = state; _state.SetContext(this); }
        public void SelectCar() => _state.SelectCar();
        public void ConfirmOrder() => _state.ConfirmOrder();
        public void CarArrived() => _state.CarArrived();
        public void StartTrip() => _state.StartTrip();
        public void CompleteTrip() => _state.CompleteTrip();
        public void CancelOrder() => _state.CancelOrder();
    }
}
EOF


cat > Program.cs <<'EOF'
using System;
using TaxiOrderSystem;
using TaxiOrderSystem.States;
class Program
{
    static void Main(string[] args)
    {
        TaxiOrderContext order = new TaxiOrderContext(new IdleState());
        order.SelectCar();
        order.ConfirmOrder();
        order.CarArrived();
        order.StartTrip();
        order.CompleteTrip();
        order.CancelOrder();
    }
}
EOF

echo "✔ Setup complete! Now run: dotnet run"
