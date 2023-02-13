Return-Path: <virtio-comment-return-4222-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
 <20230213055946-mutt-send-email-mst@kernel.org> <CAJs=3_AsGHMCvSQeP7pfrax1VAy4U+W0LmsaozGFuydqFUAiig@mail.gmail.com>
 <20230213072917-mutt-send-email-mst@kernel.org> <CAJs=3_B_ZXFg=ARoJYkoCQveeoo9myuL09U6KdSwtrMY1ias9Q@mail.gmail.com>
 <20230213091947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230213091947-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 13 Feb 2023 17:05:21 +0200
Message-ID: <CAJs=3_AD_3eQhNYw-+xs3x7s3EcJKKq_TrMFC=jYt-eMmcYx6w@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

> ok so the event we are looking for is "coalescing parameters are met".
> It is ok but I would like something that works even if
> there is no coalescing. How about "notification conditions are met" then?
> The coalescing parameters specify the conditions then
>

Sounds good.

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

