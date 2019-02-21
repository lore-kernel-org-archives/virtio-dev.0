Return-Path: virtio-dev-return-5478-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A85A9860B9
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 06:55:17 +0000 (UTC)
Date: Thu, 21 Feb 2019 07:55:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221065509.zmjrlgihbw3h6flr@sirius.home.kraxel.org>
References: <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190212131638.GF2715@work-vm>
 <20190212082555-mutt-send-email-mst@kernel.org>
 <CAEkmjvX=qMWNr2v-fELh5VFRhfFHcjQpmYPUMSTT6QNFfmLqbQ@mail.gmail.com>
 <20190219071756.f5qayejwls66jjhb@sirius.home.kraxel.org>
 <CAEkmjvXpAc1KZpYvfQa8jPzrh0MxpHNGPZ1LAH=5nQyRNCaTUw@mail.gmail.com>
 <20190220065152.44xv26wjtopkdnu2@sirius.home.kraxel.org>
 <CAEkmjvVcCYYk_ssmU+F19qMbgMmZquhMqmfhV6pwtBfeBEjqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvVcCYYk_ssmU+F19qMbgMmZquhMqmfhV6pwtBfeBEjqJA@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Non-linux systems obviously need something else for the job.  The
> > guest/host implementation details don't affect the virtio-gpu specs
> > though.
> 
> While we're talking about this: what is your plan for virtio-gpu
> implementations for non-Linux guests/hosts?

IIRC someone is working on windows guest drivers, don't know what the
current status is though.  edk2 (uefi firmware) has a driver too.  I'm
not aware on any other guest drivers, and I don't have any plans
personally (and that isn't going to change anytime soon, I'm busy enough
with linux alone).

On the host side virtio-gpu (without virgl) works just fine on any
platform supported by qemu, including *bsd, macos and windows.  I have
no idea if and how virtio-gpu buffers could be shared with other
processes on non-linux platforms though.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

