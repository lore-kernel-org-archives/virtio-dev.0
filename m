Return-Path: virtio-dev-return-5482-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01B0F9860BA
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 10:03:55 +0000 (UTC)
Date: Thu, 21 Feb 2019 10:03:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221100330.GC2605@work-vm>
References: <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190219071222.jjebzcbh55kwlspn@sirius.home.kraxel.org>
 <CAEkmjvVA_pxL7FyR4p+u5LH4JfBNOFgAJf-B3573OM58pAD7+A@mail.gmail.com>
 <20190220070213.3uetjgzzlf5qojan@sirius.home.kraxel.org>
 <CAEkmjvWEBfd1=JCkavhwdtEUSiP-Vy+RfLcLQLgaRXS+dN9PYw@mail.gmail.com>
 <20190221072950.tcii5np5dsk4wvyd@sirius.home.kraxel.org>
 <20190221092455.GB2605@work-vm>
 <20190221095902.mfa54mu7b4q5524p@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221095902.mfa54mu7b4q5524p@sirius.home.kraxel.org>
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Frank Yang <lfy@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> > > Note:  I think using a pci memory bar (aka host memory mapped into the
> > > guest) as backing storage for dma-bufs isn't going to work.
> > 
> > (Not knowing dma-bufs) but could you explain why?
> 
> Many places in the linux kernel assume dma-bufs are built out of normal
> ram pages (i.e. something backed by struct page).  Which is not the case
> for pci memory bars which are typically ioremapped() (completely or in
> chunks) to access them.

Ah OK, so it's the view from inside the guest that's the problem.

Dave


> cheers,
>   Gerd
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

