Return-Path: <virtio-comment-return-4274-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230216073222.1208265-1-alvaro.karsz@solid-run.com> <9db3b645-cc5e-5b96-24b2-7b9fda67053c@linux.alibaba.com>
In-Reply-To: <9db3b645-cc5e-5b96-24b2-7b9fda67053c@linux.alibaba.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 16 Feb 2023 10:40:10 +0200
Message-ID: <CAJs=3_DbSMTM=AmWqXAAE82Sa_JSJHzS=tss_UxsOFmc57HN6Q@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v4] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, parav@nvidia.com, david.edmondson@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Heng,

> > +When the device has non-zero \field{usecs} and non-zero \field{max_packets}, it starts counting usecs and packets upon receiving/sending a packet.
> > +The device counts packets and usecs for each receive virtqueue and transmit virtqueue separately.
> > +In this case, the notification conditions are met when \field{usecs} usecs elapses, or upon sending/receiving \field{max_packets} packets, whichever happens first.
> > +
>
> Hi, Alvaro.
>
> "when \field{usecs} usecs elapses"  --> "when \field{usecs} elapses", right?

Actually, no.
\field{usecs} refers to the field in the struct.
usecs refers to the units of measurement.

So if for example \field{usecs} = 40, then it evaluates to 40 usecs ->
"are met when 40 usecs elapses".

I can change the field name in the struct to "max_usecs" if people
think it's necessary.

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

