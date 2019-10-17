Return-Path: virtio-dev-return-6252-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98342986007
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 10:22:41 +0000 (UTC)
Date: Thu, 17 Oct 2019 12:22:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191017102239.7ekykhe5ngbsqabz@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <20190923085637.bsaevedklweijgya@sirius.home.kraxel.org>
 <CAAFQd5Ba-REZU9=rdm3J6NRqqeAUFdCV7SJ_WdO2BHyKNBN7TQ@mail.gmail.com>
 <20191014121914.lyptm3gdmekvcu6v@sirius.home.kraxel.org>
 <CAAFQd5CaxYoXQ6z4pmdTG3FDN8ccEk3sHMnSkoNwL2==hk6znQ@mail.gmail.com>
 <20191017074416.wrndxdwntynqmpm4@sirius.home.kraxel.org>
 <CAAFQd5Dh-VE2v=uX1bqKywwELxrH1a9wsRAine2=AVe3gQFt4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5Dh-VE2v=uX1bqKywwELxrH1a9wsRAine2=AVe3gQFt4w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Tomasz Figa <tfiga@chromium.org>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

> > I doubt you can handle pci memory bars like regular ram when it comes to
> > dma and iommu support.  There is a reason we have p2pdma in the first
> > place ...
> 
> The thing is that such bars would be actually backed by regular host
> RAM. Do we really need the complexity of real PCI bar handling for
> that?

Well, taking shortcuts because of virtualization-specific assumptions
already caused problems in the past.  See the messy iommu handling we
have in virtio-pci for example.

So I don't feel like going the "we know it's just normal pages, so lets
simplify things" route.

Beside that hostmap isn't important for secure buffers, we wouldn't
allow the guest mapping them anyway ;)

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

