Return-Path: virtio-dev-return-7183-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C72D2985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 15:11:49 +0000 (UTC)
MIME-Version: 1.0
References: <20200424164239.10723.58352.stgit@localhost.localdomain> <24b5a6e2-0062-4d73-db9d-2c811c7b7751@redhat.com>
In-Reply-To: <24b5a6e2-0062-4d73-db9d-2c811c7b7751@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 27 Apr 2020 08:11:35 -0700
Message-ID: <CAKgT0Ue6X7fRjgmO_1JKdRQ35oCkpkFzCptoOVB0DTUUcu+a5w@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v22 QEMU 0/5] virtio-balloon: add support
 for page poison reporting and free page reporting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Apr 27, 2020 at 1:21 AM David Hildenbrand <david@redhat.com> wrote:
>
> Except one minor nit, looks good to me. We'll have to take care of
> compat handling regarding patch #4 as soon as we have 5.0 compat
> machines in place.

I will clean up the one comment and submit later today if there is no
other follow-up.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

