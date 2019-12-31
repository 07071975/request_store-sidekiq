module RequestStore
  module Sidekiq
    class ClientMiddleware
      def call(worker_class, job, queue, redis_pool = nil)
        if RequestStore.store[:request_id]
          job['request_id'] = RequestStore.store[:request_id]
        end
        if RequestStore.store[:psp_id]
          job['psp_id'] = RequestStore.store[:psp_id]
        end
        yield
      end
    end
  end
end
