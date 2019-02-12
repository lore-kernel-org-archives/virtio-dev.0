Return-Path: virtio-dev-return-5400-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1C0F985B32
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 13:28:00 +0000 (UTC)
Date: Tue, 12 Feb 2019 08:27:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212082555-mutt-send-email-mst@kernel.org>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190212131638.GF2715@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212131638.GF2715@work-vm>
Subject: Re: [virtio-dev] Memory sharing device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Frank Yang <lfy@google.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 01:16:39PM +0000, Dr. David Alan Gilbert wrote:
> > somehow? I.e., should there be a standard way to send Shmid/offset/size to
> > other devices, or have that be a standard struct in the hypervisor?
> 
> That I don't know how to do - because then you need a way to
> associate different devices.
> 
> Dave

We could come up with a way maybe but why? Are there so many devices?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

