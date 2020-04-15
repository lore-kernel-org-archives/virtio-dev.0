Return-Path: virtio-dev-return-7072-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A5AA985FAD
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Apr 2020 18:34:03 +0000 (UTC)
MIME-Version: 1.0
References: <20200415174318.13597.99753.stgit@localhost.localdomain> <30194715-bd6d-42df-2de0-6d54ad5a1136@redhat.com>
In-Reply-To: <30194715-bd6d-42df-2de0-6d54ad5a1136@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 11:33:50 -0700
Message-ID: <CAKgT0UdVA48iUzd45tG-S-Md8Cb4S90aztcUgs4H5sLX-W9XkA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH] virtio-balloon: Avoid using the word 'report' when
 referring to free page hinting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 15, 2020 at 10:46 AM David Hildenbrand <david@redhat.com> wrote=
:
> Can we also change the comment of
>
> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT  /* VQ to report free pages */
>
> ?
>
> Thanks!

No problem. I will update and submit a v2.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

