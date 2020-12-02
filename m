Return-Path: virtio-dev-return-7879-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0AA19865B9
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Dec 2020 11:53:09 +0000 (UTC)
Date: Wed, 2 Dec 2020 12:52:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20201202125249.00be36e6.cohuck@redhat.com>
In-Reply-To: <91df7aad-02fc-13ca-4592-0b1bc131c7e4@metux.net>
References: <91df7aad-02fc-13ca-4592-0b1bc131c7e4@metux.net>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Virtio device ID allocation
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2 Dec 2020 12:29:41 +0100
"Enrico Weigelt, metux IT consult" <lkml@metux.net> wrote:

> Hello folks,
> 
> 
> I'd like to allocate some virtio devices IDs:

The general procedure would be to send a patch to the virtio-comments
list, open an issue, and then request a vote. See
https://github.com/oasis-tcs/virtio-spec#providing-feedback

> 
> a) IDs already used by the Linux kernel:
> 
>    VIRTIO_ID_FS             = 26
>    VIRTIO_ID_PMEM           = 27
>    VIRTIO_ID_MAC80211_HWSIM = 29

These are already in the git tree (even though not yet in an official
version).

> 
> b) new devices developed by myself:
> 
>    VIRTIO_ID_GPIO           = 30
>    VIRTIO_ID_LED            = 31

These two are already reserved for video {en|de}coder devices; you'll
need to bump the numbers beyond 35.

> 
>    (attached spec for gpio, led is still under development)

I don't think attachments will work on this list -- maybe post it as a
separate patch?

> 
> c) planned devices: (no IDs chosen yet)
> 
>    VIRTIO_CAN
>    VIRTIO_I2C

I2C has already been reserved (34); there's also discussion happening
about the proposed spec.

>    VIRTIO_REGULATOR
> 
> 
> best regards,
> 
> --mtx
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

