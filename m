Return-Path: virtio-dev-return-4144-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9360E5818F11
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 May 2018 14:25:35 -0700 (PDT)
Date: Thu, 24 May 2018 00:25:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524002447-mutt-send-email-mst@kernel.org>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
 <20180412151232.17506-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412151232.17506-4-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 3/6] vhost-user: support receiving file descriptors in
 slave_read
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 12, 2018 at 11:12:29PM +0800, Tiwei Bie wrote:
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>


Thinking about it, I think we should add a protocol
feature for this. This way remote can find out whether
it's safe to send this data to us.

> ---
>  hw/virtio/vhost-user.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 91edd95453..9cea2c8c51 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -854,14 +854,44 @@ static void slave_read(void *opaque)
>      VhostUserHeader hdr = { 0, };
>      VhostUserPayload payload = { 0, };
>      int size, ret = 0;
> +    struct iovec iov;
> +    struct msghdr msgh;
> +    int fd = -1;
> +    char control[CMSG_SPACE(sizeof(fd))];
> +    struct cmsghdr *cmsg;
> +    size_t fdsize;
> +
> +    memset(&msgh, 0, sizeof(msgh));
> +    msgh.msg_iov = &iov;
> +    msgh.msg_iovlen = 1;
> +    msgh.msg_control = control;
> +    msgh.msg_controllen = sizeof(control);
>  
>      /* Read header */
> -    size = read(u->slave_fd, &hdr, VHOST_USER_HDR_SIZE);
> +    iov.iov_base = &hdr;
> +    iov.iov_len = VHOST_USER_HDR_SIZE;
> +
> +    size = recvmsg(u->slave_fd, &msgh, 0);
>      if (size != VHOST_USER_HDR_SIZE) {
>          error_report("Failed to read from slave.");
>          goto err;
>      }
>  
> +    if (msgh.msg_flags & MSG_CTRUNC) {
> +        error_report("Truncated message.");
> +        goto err;
> +    }
> +
> +    for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
> +         cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
> +            if (cmsg->cmsg_level == SOL_SOCKET &&
> +                cmsg->cmsg_type == SCM_RIGHTS) {
> +                    fdsize = cmsg->cmsg_len - CMSG_LEN(0);
> +                    memcpy(&fd, CMSG_DATA(cmsg), fdsize);
> +                    break;
> +            }
> +    }
> +
>      if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
>          error_report("Failed to read msg header."
>                  " Size %d exceeds the maximum %zu.", hdr.size,
> @@ -885,9 +915,15 @@ static void slave_read(void *opaque)
>          break;
>      default:
>          error_report("Received unexpected msg type.");
> +        if (fd != -1) {
> +            close(fd);
> +        }
>          ret = -EINVAL;
>      }
>  
> +    /* Message handlers need to make sure that fd will be consumed. */
> +    fd = -1;
> +
>      /*
>       * REPLY_ACK feature handling. Other reply types has to be managed
>       * directly in their request handlers.
> @@ -920,6 +956,9 @@ err:
>      qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
>      close(u->slave_fd);
>      u->slave_fd = -1;
> +    if (fd != -1) {
> +        close(fd);
> +    }
>      return;
>  }
>  
> -- 
> 2.11.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

