Return-Path: <virtio-comment-return-4177-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
 <601ef040-bac2-dd6d-b32c-2029be17c071@linux.alibaba.com> <CAJs=3_Az-v8dm3NO6hgEm27zPfk2=6PMu93rzzvinnuD7MHUKQ@mail.gmail.com>
 <20230212152122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230212152122-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 12 Feb 2023 22:53:50 +0200
Message-ID: <CAJs=3_CpUtc36kxQURiZhpDe4YYasWDQYoMpdfKaEq5LE0v3Bw@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> I'm not sure the specific property is even a feature and not a bug.
> One can argue e.g. that ethtool should fail with EBUSY rather
> than being silently overwritten.
> Thats why I feel this kind of policy is best set by driver.

When you write "set by driver", you mean that [X] the spec needs to
define the driver behavior in this case, or that [Y] every driver
should decide what's best?

I'll answer to [X], if you meant [Y] the following part is not relevant.

If we talk implementation here, I would probably implement it like that:

net_dim_start_tx:
        set_ethtool_blocking_bool
        save_current_coalescing_params  # Maybe?
        clear_all_tx_coalescing_params     # NOTF_COAL_TX_SET 0
        do_net_dim

net_dim_stop_tx:
      restore_prev_ethtool_coalesing_params
      clear_ethtool_blocking_bool


It's reasonable to assume that sending a ethtool set coalesce when
netdim is operating will affect the performance.

But, windows' virtio_net driver may want to use _CTRL_NOTF_COAL_TX_SET
in its adaptive algorithm, and may have no userspace tool to configure
these parameters.
If we force the driver to clear/block some commands while using
others, we may do more harm than good in windows' case.

This is just my personal perspective.

I think that this is an important feature either way.

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

