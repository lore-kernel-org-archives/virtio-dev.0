Return-Path: <virtio-comment-return-4329-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230216145611.1361327-1-alvaro.karsz@solid-run.com>
 <20230217043305-mutt-send-email-mst@kernel.org> <CAJs=3_Bkg+hRTaV2ooZHwOib666yFzRGgVosd_pO7EsZHokf-w@mail.gmail.com>
 <20230217052731-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217052731-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 17 Feb 2023 12:36:32 +0200
Message-ID: <CAJs=3_B-q6NbtNTqZuwyHn6eENYb+NpUijDXvnwW55bBYQcyGg@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v5] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, david.edmondson@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

> sounds good. maybe "counting packets and microseconds"? to make clear
> timer resets too.
>
> > I don't really mind, If you think that the device implementation is
> > not essential here and we should add your suggestion, I'm ok with
> > that.
>
> I don't mind, your proposal seems good too.

Ok, so I'll add:
"... whichever happens first.
After  the notification conditions are met, the device waits for the
next packet and starts counting  packets and microseconds again."

Thanks!

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

