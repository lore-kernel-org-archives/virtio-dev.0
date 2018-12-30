Return-Path: virtio-dev-return-5217-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52171983B8D
	for <virtio-dev@lists.oasis-open.org>; Sun, 30 Dec 2018 06:06:11 +0000 (UTC)
Date: Sun, 30 Dec 2018 07:06:00 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
	<286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181230070600.512bbb8b@oc2783563651>
Subject: [virtio-dev] Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, 29 Dec 2018 02:45:49 +0000
"Wang, Wei W" <wei.w.wang@intel.com> wrote:

> On Friday, December 28, 2018 3:57 PM, Christian Borntraeger wrote:
> > On 28.12.2018 03:26, Wei Wang wrote:
> > > Some vqs don't need to be allocated when the related feature bits are
> > > disabled. Callers notice the vq allocation layer by setting the
> > > related names[i] to be NULL.
> > >
> > > This patch series fixes the find_vqs implementations to handle this case.
> > 
> > So the random crashes during boot are gone.
> > What still does not work is actually using the balloon.
> > 
> > So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
> > Seems to be a deadlock in the virtio-ccw code.  We seem to call the config
> > code in the interrupt handler.
> 
> Yes. It reads a config register from the interrupt handler. Do you know why ccw doesn't support it and has some internal lock that caused the deadlock issue?
>  
> Best,
> Wei

I guess you are the first one trying to read virtio config from within
interrupt context. AFAICT this never worked.

About what happens. The apidoc of ccw_device_start() says it needs to be
called with the ccw device lock held, so ccw_io_helper() tries to take
it (since forever I guess). OTOH do_cio_interrupt() takes the subchannel
lock and io_subchannel_initialize_dev() makes the ccw device lock be the
subchannel lock. That means when one tries to get virtio config form
within a cio interrupt context we deadlock, because we try to take a lock
we already have.

That said, I don't think this limitation is by design (i.e. intended).
Maybe Connie can help us with that question. AFAIK we have nothing
documented regarding this (neither that can nor can't).

Obviously, there are multiple ways around this problem, and at the
moment I can't tell which would be my preferred one.

Regards,
Halil




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

