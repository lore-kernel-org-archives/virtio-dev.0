Return-Path: virtio-dev-return-4172-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E93E31CB80F1
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 May 2018 09:25:01 -0700 (PDT)
Date: Fri, 25 May 2018 00:25:19 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180524162519.GA24120@debian>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
 <20180524103336.21233-5-tiwei.bie@intel.com>
 <20180524184438-mutt-send-email-mst@kernel.org>
 <20180524160549.GA15321@debian>
 <20180524191330-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524191330-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH 4/6] vhost-user: support registering external host
 notifiers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 24, 2018 at 07:15:24PM +0300, Michael S. Tsirkin wrote:
> On Fri, May 25, 2018 at 12:05:50AM +0800, Tiwei Bie wrote:
> > On Thu, May 24, 2018 at 06:49:47PM +0300, Michael S. Tsirkin wrote:
> > > On Thu, May 24, 2018 at 06:33:34PM +0800, Tiwei Bie wrote:
> > > > This patch introduces VHOST_USER_PROTOCOL_F_HOST_NOTIFIER.
> > > > With this feature negotiated, vhost-user backend can register
> > > > memory region based host notifiers. And it will allow the guest
> > > > driver in the VM to notify the hardware accelerator at the
> > > > vhost-user backend directly.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > 
> > > So maybe we don't need a new VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD?
> > > Let's check VHOST_USER_PROTOCOL_F_HOST_NOTIFIER instead?
> > 
> > Yeah. I think it would be the best choice!
> > 
> > If this feature (HOST NOTIFIER) is negotiated, it means
> > the QEMU is able to safely receive (the expected number
> > of) file descriptors.
> > 
> > > 
> > > > ---
> > [...]
> > > > +typedef struct VhostUserHostNotifier {
> > > > +    MemoryRegion mr;
> > > > +    void *addr;
> > > > +    bool set;
> > > > +} VhostUserHostNotifier;
> > > >  
> > > >  typedef struct VhostUserState {
> > > >      CharBackend *chr;
> > > > +    VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
> > > >  } VhostUserState;
> > > 
> > > So this notifier is per-queue. Can't we maintain it in
> > > NetVhostUserState then?
> > 
> > This notifier is per virtio-queue. But NetVhostUserState
> > is per net-queue-pair.
> > 
> > And ideally, I think this structure shouldn't be visible
> > to net/vhost-user, vhost-user-scsi, vhost-user-crypto, etc.
> > 
> > Best regards,
> > Tiwei Bie
> 
> I wonder whether we can create a new per vq structure.

Maybe something like:

typedef struct VhostUserStatePerVQ {
    VhostUserHostNotifier notifier;
} VhostUserStatePerVQ;

typedef struct VhostUserState {
    CharBackend *chr;
    VhostUserStatePerVQ queue[VIRTIO_QUEUE_MAX];
} VhostUserState;

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

