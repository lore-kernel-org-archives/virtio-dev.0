Return-Path: virtio-dev-return-8159-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 317BD986298
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 May 2021 09:24:27 +0000 (UTC)
Date: Tue, 11 May 2021 11:24:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210511112420.4f45f055.cohuck@redhat.com>
In-Reply-To: <CABATKF-_8SoR0=azxjGwMi2YKGUG0jW95nd8fKdC2-KJcL7n8Q@mail.gmail.com>
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
	<20210430125502.43535749.cohuck@redhat.com>
	<CABATKF-_8SoR0=azxjGwMi2YKGUG0jW95nd8fKdC2-KJcL7n8Q@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: Enrico Granata <egranata@google.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 7 May 2021 16:06:41 -0700
Hao Chen <chenhaosjtuacm@google.com> wrote:

> > Your client seems to introduce line wraps...  
> 
> Thanks for pointing it out, we will fix it in the following patches.
> 
> > Do these two types need to be handled differently? If I set up a
> > subscription "poll this parameter every n ms", it doesn't really matter
> > why the parameter changes, does it? In any case, it is not under
> > control of the driver, as "actions of the external system" may also
> > change a mutable parameter.  
> 
> The reason we want to handle "MUTABLE" and "CONTNUOUS" differently is,
> the MUTABLE values are not constantly changing, so the device may be able to
> send every updates of it to the driver; while CONTINUOUS values are changing
> frequently (e.g., sensor outputs) and the device should decide how to sample it
> and provide a sample rate range ("min_sample_freq" and "max_sample_freq")

Can you add that explanation to the paragraph? It gives good guidance
when to use which type.

> 
> > s/device-readable// ?  
> 
> If I understand correctly, the driver need to fill the virtqueues no
> matter who is the
> reader, so "device-readable" is necessary here. What do you think?

But isn't the eventq supposed to relay information from the device to
the driver?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

