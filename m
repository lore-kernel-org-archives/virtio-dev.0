Return-Path: virtio-comment-return-1172-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20200227113735.23605-1-peter.hilber@opensynergy.com>
 <20200317192053.15665-1-peter.hilber@opensynergy.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200317192053.15665-1-peter.hilber@opensynergy.com>
Date: Fri, 27 Mar 2020 17:19:47 +0000
Message-ID: <87369tn2a4.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v3] Add virtio SCMI device specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, linux-arm-kernel@lists.infradead.org, Souvik.Chakravarty@arm.com, Sudeep.Holla@arm.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Peter Hilber <peter.hilber@opensynergy.com> writes:

> This patch proposes a new virtio device for the Arm SCMI protocol.
>
> The device provides a simple transport for the Arm SCMI protocol[1]. The
> *S*ystem *C*ontrol and *M*anagement *I*nterface protocol allows speaking
> to system controllers that allow orchestrating things like power
> management, system state management and sensor access. The SCMI protocol
> is used on SoCs where multiple cores and co-processors need access to
> these resources.
>
> The virtio transport allows making use of this protocol in virtualized
> systems.
>
> [1] https://developer.arm.com/docs/den0056/b
>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
<snip>
> +
> +\subsubsection{Shared Memory Operation}
> +
> +Various SCMI protocols define statistics shared memory regions (for
> +statistics and sensor values).
> +
> +\devicenormative{\paragraph}{Shared Memory Operation}{Device Types / SCM=
I Device / Device Operation / Shared Memory Operation}
> +
> +If VIRTIO_SCMI_F_SHARED_MEMORY was negotiated, the device MAY implement
> +an SCMI statistics shared memory region using a virtio shared memory
> +region.

AFAICT this is the first usage of shmid in the virtio spec so I have
some questions. The spec says:

  Memory consistency rules vary depending on the region and the device
  and they will be specified as required by each device.

So what are the rules for memory consistency for these regions:

  - are they read-only w.r.t the guest? (maybe this is implicit?)
  - how does the guest know when they have been updated?
  - how goes the guest know it hasn't read a value mid-update?

> +
> +If the device implements a shared memory region, the device MUST assign
> +the corresponding shmid as per the following table:
> +
> +\begin{tabular}{|l|l|}
> +\hline
> +SCMI statistics shared memory region & Virtio shmid \\
> +\hline \hline
> +Power state statistics shared memory region & 1 \\
> +\hline
> +Performance domain statistics shared memory region & 2 \\
> +\hline
> +Sensor Values Shared Memory & 3 \\
> +\hline
> +Reserved for future use & 4 to 0x7F \\
> +\hline
> +Vendor-specific statistics shared memory regions & 0x80 to 0xFF \\
> +\hline
> +Reserved for future use & 0x100 and greater \\
> +\hline
> +\end{tabular}


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

