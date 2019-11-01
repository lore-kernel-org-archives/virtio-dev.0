Return-Path: virtio-dev-return-6274-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0728985CF7
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Nov 2019 04:07:04 +0000 (UTC)
Date: Fri, 1 Nov 2019 00:06:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191031234601-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] Re: presentation at kvm forum and pagefaults
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

Regarding the presentation I gave at the kvm forum
on pagefaults.

Two points:


1. pagefaults are important not just for migration.
They are important for performance features such as
autonuma and huge pages, since this relies on moving
pages around.
Migration can maybe be solved by switch to software but
this is not a good solution for numa and thp  since
at a given time some page is likely being moved.




2.  For devices such as networking RX order in which buffers are
used *does not matter*.
Thus if a device gets a fault in response to attempt to store a buffer
into memory, it can just re-try, using the next buffer in queue instead.

This works because normally buffers can be used out of order by device.

The faulted buffer will be reused by another buffer when driver notifies
device page has been faulted in.

Note buffers are processed by buffer in the order in which they have
been used, *not* the order in which they have been put in the queue.  So
this will *not* cause any packet reordering for the driver.

Packets will only get dropped if all buffers are swapped
out, which should be rare with a large RX queue.


As I said at the forum, a side buffer for X packets
to be stored temporarily is also additionally possible. But with the above
it is no longer strictly required.


This conflicts with the IN_ORDER feature flag, I guess we will have to
re-think this flag then. If we do feel we need to salvage IN_ORDER as is,
maybe device can use the buffer with length 0 and driver will re-post it
later, but I am not I am not sure about this since involving the VF
driver seems inelegant.


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

