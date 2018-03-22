Return-Path: virtio-dev-return-3632-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E08BA5819045
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Mar 2018 08:13:56 -0700 (PDT)
Date: Thu, 22 Mar 2018 17:13:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180322165800-mutt-send-email-mst@kernel.org>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180319071537.28649-3-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319071537.28649-3-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v2 2/6] vhost-user: introduce shared vhost-user state
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 19, 2018 at 03:15:33PM +0800, Tiwei Bie wrote:
> @@ -22,7 +23,7 @@
>  
>  typedef struct VhostUserState {
>      NetClientState nc;
> -    CharBackend chr; /* only queue index 0 */
> +    VhostUser vhost_user; /* only queue index 0 */
>      VHostNetState *vhost_net;
>      guint watch;
>      uint64_t acked_features;

Is the comment still valid?

> @@ -64,7 +65,7 @@ static void vhost_user_stop(int queues, NetClientState *ncs[])
>      }
>  }
>  
> -static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
> +static int vhost_user_start(int queues, NetClientState *ncs[], void *be)
>  {
>      VhostNetOptions options;
>      struct vhost_net *net = NULL;

Type safety going away here. This is actually pretty scary:
are we sure no users cast this pointer to CharBackend?

For example it seems that vhost_user_init does exactly that.

Need to find a way to add type safety before making
such a change.


> @@ -158,7 +159,7 @@ static void vhost_user_cleanup(NetClientState *nc)
>              g_source_remove(s->watch);
>              s->watch = 0;
>          }
> -        qemu_chr_fe_deinit(&s->chr, true);
> +        qemu_chr_fe_deinit(&s->vhost_user.chr, true);
>      }
>  
>      qemu_purge_queued_packets(nc);
> @@ -192,7 +193,7 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
>  {
>      VhostUserState *s = opaque;
>  
> -    qemu_chr_fe_disconnect(&s->chr);
> +    qemu_chr_fe_disconnect(&s->vhost_user.chr);
>  
>      return TRUE;
>  }
> @@ -217,7 +218,8 @@ static void chr_closed_bh(void *opaque)
>      qmp_set_link(name, false, &err);
>      vhost_user_stop(queues, ncs);
>  
> -    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
> +    qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL,
> +                             net_vhost_user_event,
>                               NULL, opaque, NULL, true);
>  
>      if (err) {
> @@ -240,15 +242,15 @@ static void net_vhost_user_event(void *opaque, int event)
>      assert(queues < MAX_QUEUE_NUM);
>  
>      s = DO_UPCAST(VhostUserState, nc, ncs[0]);
> -    chr = qemu_chr_fe_get_driver(&s->chr);
> +    chr = qemu_chr_fe_get_driver(&s->vhost_user.chr);
>      trace_vhost_user_event(chr->label, event);
>      switch (event) {
>      case CHR_EVENT_OPENED:
> -        if (vhost_user_start(queues, ncs, &s->chr) < 0) {
> -            qemu_chr_fe_disconnect(&s->chr);
> +        if (vhost_user_start(queues, ncs, &s->vhost_user) < 0) {
> +            qemu_chr_fe_disconnect(&s->vhost_user.chr);
>              return;
>          }
> -        s->watch = qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> +        s->watch = qemu_chr_fe_add_watch(&s->vhost_user.chr, G_IO_HUP,
>                                           net_vhost_user_watch, s);
>          qmp_set_link(name, true, &err);
>          s->started = true;
> @@ -264,8 +266,8 @@ static void net_vhost_user_event(void *opaque, int event)
>  
>              g_source_remove(s->watch);
>              s->watch = 0;
> -            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
> -                                     NULL, NULL, false);
> +            qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL, NULL,
> +                                     NULL, NULL, NULL, false);
>  
>              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
>          }
> @@ -297,7 +299,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>          if (!nc0) {
>              nc0 = nc;
>              s = DO_UPCAST(VhostUserState, nc, nc);
> -            if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
> +            if (!qemu_chr_fe_init(&s->vhost_user.chr, chr, &err)) {
>                  error_report_err(err);
>                  return -1;
>              }
> @@ -307,11 +309,11 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>  
>      s = DO_UPCAST(VhostUserState, nc, nc0);
>      do {
> -        if (qemu_chr_fe_wait_connected(&s->chr, &err) < 0) {
> +        if (qemu_chr_fe_wait_connected(&s->vhost_user.chr, &err) < 0) {
>              error_report_err(err);
>              return -1;
>          }
> -        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> +        qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL,
>                                   net_vhost_user_event, NULL, nc0->name, NULL,
>                                   true);
>      } while (!s->started);
> -- 
> 2.11.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

