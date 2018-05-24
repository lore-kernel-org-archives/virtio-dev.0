Return-Path: virtio-dev-return-4149-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BB5A5819145
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 May 2018 00:03:11 -0700 (PDT)
Date: Thu, 24 May 2018 15:03:28 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180524070328.GA15430@debian>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
 <20180412151232.17506-3-tiwei.bie@intel.com>
 <20180523163116-mutt-send-email-mst@kernel.org>
 <20180523183444-mutt-send-email-mst@kernel.org>
 <20180523184001-mutt-send-email-mst@kernel.org>
 <20180523232101.GB15604@debian>
 <20180524022440.GA20792@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524022440.GA20792@debian>
Subject: [virtio-dev] Re: [PATCH v3 2/6] vhost-user: introduce shared vhost-user state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 24, 2018 at 10:24:40AM +0800, Tiwei Bie wrote:
[...]
> > > +
> > >      qemu_purge_queued_packets(nc);
> > >  }
> > >  
> > > @@ -341,7 +342,6 @@ err:
> > >      if (user) {
> > >          vhost_user_cleanup(user);
> > >          g_free(user);
> > > -        s->vhost_user = NULL;
> 
> I don't get why cannot zero it in this case.

Hmm.. Please just ignore above comment.
Thanks for catching this bug!

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

