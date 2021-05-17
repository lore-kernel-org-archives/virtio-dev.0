Return-Path: virtio-dev-return-8166-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9780D985E64
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 May 2021 19:28:26 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
In-Reply-To: <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Mon, 17 May 2021 12:28:14 -0700
Message-ID: <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device specification
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> Can you share a bit about the reason for defining a new VIRTIO device
> instead of running an existing key-value store over virtio-vsock or
> virtio-net?

The reason for defining a virtio-parameter-server device is we are interacting
with some devices in a "key-value store" pattern. For example, we interact with
"vehicle device" in Android using this pattern.

Ad-hoc protocol over vsock to a k-v store works, but we want to
standardize these
types of devices so that the VM doesn't need to know the
vendor-specific key-value
protocols for a specific device implementation.

Thanks,
Hao

On Thu, May 13, 2021 at 7:46 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Apr 20, 2021 at 05:33:17PM -0700, Hao Chen wrote:
> > This patch introduces a new type of device: parameter server. The device
> > acts as a key-value store and the driver can read from, write to or
> > subscribe to the properties in the server.
>
> Can you share a bit about the reason for defining a new VIRTIO device
> instead of running an existing key-value store over virtio-vsock or
> virtio-net?
>
> I'm not against adding this new device but I would like to understand
> what the advantages are.
>
> Thanks,
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

