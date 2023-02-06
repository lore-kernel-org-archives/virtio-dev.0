Return-Path: <virtio-comment-return-3966-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116152504-mutt-send-email-mst@kernel.org> <PH0PR12MB548176D1EC760DB15826B08DDCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116160634-mutt-send-email-mst@kernel.org> <CAJs=3_At3KQ0DvZ6P3bpZBvh9H3L5HHMeO-zq594dFG+MHA=bg@mail.gmail.com>
 <20230117101430-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230117101430-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 6 Feb 2023 10:10:55 +0200
Message-ID: <CAJs=3_DJHcNyMTiG67KjE=mppEqjV0af37uytQ0Rby5Z-A_NxQ@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH v2] virtio_net: support
 low and high rate of notification coalescing
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
I'm going to drop this patch and focus on a new patch to fix the
existing notification coalescing feature, including:
- Unifying the virtio_net_ctrl_coal structs.
- Clarifying that the coalescing commands are best-effort.
- Specifying coalescing in respect to delivering interrupts when config changes.

Thanks everyone for the comments.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

