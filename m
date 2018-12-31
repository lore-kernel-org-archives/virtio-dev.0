Return-Path: virtio-dev-return-5219-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7522A98439A
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Dec 2018 23:40:29 +0000 (UTC)
Date: Tue, 1 Jan 2019 00:40:19 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
	<286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
	<20181230070600.512bbb8b@oc2783563651>
	<286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190101004019.7f20aafa@oc2783563651>
Subject: Re: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation
 issues
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 31 Dec 2018 06:03:51 +0000
"Wang, Wei W" <wei.w.wang@intel.com> wrote:

> On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote:
> > 
> > I guess you are the first one trying to read virtio config from within interrupt
> > context. AFAICT this never worked.
> 
> I'm not sure about "never worked". It seems to work well with virtio-pci.
> But looking forward to hearing a solid reason why reading config inside
> the handler is forbidden (if that's true).

By "never worked" I meant "never worked with virtio-ccw". Sorry
about the misunderstanding. Seems I've also failed to convey that I don't
know if reading config inside the handler is forbidden or not. So please
don't expect me providing the solid reasons you are looking forward to.

> 
> > About what happens. The apidoc of ccw_device_start() says it needs to be
> > called with the ccw device lock held, so ccw_io_helper() tries to take it (since
> > forever I guess). OTOH do_cio_interrupt() takes the subchannel lock and
> > io_subchannel_initialize_dev() makes the ccw device lock be the subchannel
> > lock. That means when one tries to get virtio config form within a cio
> > interrupt context we deadlock, because we try to take a lock we already have.
> > 
> > That said, I don't think this limitation is by design (i.e. intended).
> > Maybe Connie can help us with that question. AFAIK we have nothing
> > documented regarding this (neither that can nor can't).
> > 
> > Obviously, there are multiple ways around this problem, and at the moment
> > I can't tell which would be my preferred one.
> 
> Yes, it's also not difficult to tweak the virtio-balloon code to avoid that issue.
> But if that's just an issue with ccw itself, I think it's better to tweak ccw and
> remain virtio-balloon unchanged.
> 

As I said, at the moment I don't have a preference regarding the fix,
partly because I'm not sure if "reading config inside the handler" is OK
or not. Maybe Connie or Michael can help us here. I'm however sure that
commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
virtio-balloon on s390): it used to work before and does not work
after.

AFAICT tweaking the balloon code may be simpler than tweaking the
virtio-ccw (transport code). ccw_io_helper() relies on getting
an interrupt when the issued IO is done. If virtio-ccw is buggy, it
needs to be fixed, but I'm not sure it is.

Regards,
Halil

 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

