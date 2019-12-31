module RequestStore
  module Sidekiq
    class ServerMiddleware
      def call(worker, job, queue)
        if job.key?('request_id')
          set_request_id(job['request_id'])
        end
        if job.key?('psp_id')
          set_psp_id(job['psp_id'])
        end
        yield
      end

      private

      def set_request_id(request_id)
        RequestStore.store[:request_id] = request_id
      end

      def set_psp_id(psp_id)
        RequestStore.store[:psp_id] = psp_id
      end
    end
  end
end
