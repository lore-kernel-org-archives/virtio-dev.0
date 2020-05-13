Return-Path: virtio-comment-return-1237-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20200317192053.15665-1-peter.hilber@opensynergy.com>
 <20200424085114.9129-1-peter.hilber@opensynergy.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <d0034b91-8f8a-3316-b67f-4e5abde73629@opensynergy.com>
Date: Wed, 13 May 2020 12:48:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200424085114.9129-1-peter.hilber@opensynergy.com>
Content-Language: en-US
Subject: [virtio-comment] Re: [PATCH v4] Add virtio SCMI device specification
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org
Cc: linux-arm-kernel@lists.infradead.org, Souvik.Chakravarty@arm.com, Sudeep.Holla@arm.com, virtio-dev@lists.oasis-open.org, alex.bennee@linaro.org, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 24.04.20 10:51, Peter Hilber wrote:
> This patch proposes a new virtio device for the Arm SCMI protocol.
>=20
> The device provides a simple transport for the Arm SCMI protocol[1]. The
> *S*ystem *C*ontrol and *M*anagement *I*nterface protocol allows speaking
> to system controllers that allow orchestrating things like power
> management, system state management and sensor access. The SCMI protocol
> is used on SoCs where multiple cores and co-processors need access to
> these resources.
>=20
> The virtio transport allows making use of this protocol in virtualized
> systems.
>=20
> [1] https://developer.arm.com/docs/den0056/b
>=20
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>=20
> Notes:
>     Changes for v4:
>    =20
>     - Add more requirements on shared memory regions after feedback from
>       Alex Benn=C3=A9e.

I had an off-list discussion about concurrent access to SCMI shared
memory regions with the Arm SCMI spec[1] maintainer yesterday. An
upcoming new version of the Arm SCMI spec will provide a generic, more
powerful way to handle concurrent access to shared memory.

Therefore, I plan to again drop the requirements introduced in v4 in the
upcoming virtio SCMI spec patch v5.

Best regards,

Peter

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

