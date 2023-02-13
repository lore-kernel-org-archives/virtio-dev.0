Return-Path: <virtio-comment-return-4192-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 13 Feb 2023 10:33:32 +0200
Message-ID: <CAJs=3_AtbBdtceGvUa6tsiCRKgpYg+nOibJ0eoA9h9u3fKJ5cA@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: mst@redhat.com, parav@nvidia.com
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, hengqi@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Splitting this patch as suggested in v1 will be messy,

We have lines affected by multiple changes, for example:

+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and
\field{max_packets} parameters for all the receive virtqueues.

Is affected by the consolidation of the structs and by the statement
that the command should apply to all virtqueues.

Do you think that this is ok to keep it as a single patch that makes
multiple minor changes?

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

