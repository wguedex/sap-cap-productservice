using com.training as training from '../db/training';

service MyService {
    entity GetOrders as projection on training.Orders2;
}
