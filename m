Return-Path: virtio-dev-return-5455-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35798985B8C
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 07:12:29 +0000 (UTC)
Date: Tue, 19 Feb 2019 08:12:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219071222.jjebzcbh55kwlspn@sirius.home.kraxel.org>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> slots by doing so. So for Vulkan, we rely on having one large host visible
> region on the host that is a single region of host shared memory. That, is
> then sub-allocated for the guest. So there is no Vulkan host pointer that

Yes, sub-allocating will be needed for reasonable performance.

> In general though, this means that the ideal usage of host pointers would
> be to set a few regions up front for certain purposes, then share that out
> amongst other device contexts. This also facilitates sharing the memory
> between guest processes, which is useful for implementing things like
> compositors.

Guest processes in the same VM or in different VMs?

> This also features heavily for our "virtio userspace" thing.
> Since this is a common pattern, should this sharing concept be standardized
> somehow? I.e., should there be a standard way to send Shmid/offset/size to
> other devices, or have that be a standard struct in the hypervisor?

Same question: other devices of the same VM?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

