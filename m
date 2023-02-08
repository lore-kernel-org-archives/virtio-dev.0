Return-Path: <virtio-comment-return-4069-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org> <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org> <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
 <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208171348-mutt-send-email-mst@kernel.org> <PH0PR12MB5481AE46696AD124FD436DF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208172646-mutt-send-email-mst@kernel.org> <PH0PR12MB5481A6D2E191F2CC25A6D732DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481A6D2E191F2CC25A6D732DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 9 Feb 2023 00:45:42 +0200
Message-ID: <CAJs=3_ABEVQ3ZqhrXwh_K1GV3CBKLRimyvEUhZYifYSfhbM22g@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Maybe we should do something more future friendly.
We may want to add more coalescing related features in the future.
* Maybe max/min sets?
* Maybe to offload the adaptive algo to the DPU?

It will require more feature bits..

We could rename this new feature from VIRTIO_NET_F_PERQUEUE_NOTF_COAL
to something like VIRTIO_NET_F_ADVANCED_NOTF_COAL, and introduce a new
bitmask in the virto_net_config.

We can implement just one bit at first.
BIT 0 - device supports per queue coalescing sets

Then, we could add more features in the future without having to use
more feature bits.

Every device that offers VIRTIO_NET_F_ADVANCED_NOTF_COAL should
maintain a valid bitmask.

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

