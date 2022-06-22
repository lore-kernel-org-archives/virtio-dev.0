Return-Path: <virtio-comment-return-3162-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 22 Jun 2022 14:08:59 +0100
Message-ID: <87fsjwrfx5.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] virtio-media-source for cloud native workloads?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: Matt Spencer <Matt.Spencer@arm.com>, Peter Griffin <peter.griffin@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Hilber <peter.hilber@opensynergy.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

In my last survey of assigned device numbers I went through all the
currently assigned device numbers and attempted to glean their current
status. However we currently don't have any devices that might be useful
in a Cloud Native development environment.

To define terms cloud native is the idea you can build a workload
processing element as a VM and run it in the cloud. It consumes data
from virtio-devices and processes it in someway. This VM can then be
moved from being hosted in the cloud and into a real platform which
still provides it's data via a virtio device. The idea being you get the
same behaviour (as well as allowing for data to be recorded so future
debugging/tuning work can be done in the cloud).

Currently most of the virtio devices are actually data sinks - for
example for virtio-video the guest pushes data to the video device for
it to process. What we need is a device(s?) to be a source of data to
feed to these workloads.

Why virtio-media-source? Well rather than creating a device for every
data type maybe it would make more sense to have a generic device which
can advertise the data stream info in it's configuration space. This
would allow the kernel driver to then route the data to the appropriate
kernel subsystem (e.g. v4l or alsa).

Would having a virtio driver potentially feeding different sub-systems
based on configuration be a problem?

What do people think?

--=20
Alex Benn=C3=A9e

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

