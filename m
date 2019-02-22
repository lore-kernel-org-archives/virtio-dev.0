Return-Path: virtio-dev-return-5494-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2694C9860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 06:15:37 +0000 (UTC)
Date: Fri, 22 Feb 2019 01:15:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190222010657-mutt-send-email-mst@kernel.org>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Frank Yang <lfy@google.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 21, 2019 at 10:59:02AM +0100, Gerd Hoffmann wrote:
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
> 
> cheers,
>   Gerd

Can't we register PCI memory as ZONE_DEVICE?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

