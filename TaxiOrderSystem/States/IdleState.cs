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
