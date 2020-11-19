Return-Path: virtio-comment-return-1526-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
 <83052aa7-8815-ce9d-3c9f-59d863107702@redhat.com>
 <20201110053225-mutt-send-email-mst@kernel.org>
 <5a0fcb8b-80a1-d1e0-5d9f-2f6cc003adc2@redhat.com>
 <616323bf-25a5-d951-cd4c-3d67f08f5af8@intel.com>
 <20201112035331-mutt-send-email-mst@kernel.org>
 <c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com>
 <ba89c7cc-fad4-e0ca-642a-220364ffd05a@intel.com>
 <e79f44b9-8620-3635-1f60-90a4c6dd4e2e@redhat.com>
 <0a821501-ce4b-6491-c9ad-654e91c99d93@intel.com>
 <20201117082342.kcbqq3bcysdb26ko@sirius.home.kraxel.org>
 <d20aef28-61cb-61c5-f186-ed6a37467764@intel.com>
 <c146eb06-bd77-eaf2-dd8b-3a82f66b8dc2@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <3749de23-1f5e-46fd-aa26-53e06ac9608d@intel.com>
Date: Thu, 19 Nov 2020 09:41:34 +0800
MIME-Version: 1.0
In-Reply-To: <c146eb06-bd77-eaf2-dd8b-3a82f66b8dc2@redhat.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v4] virtio-i2c: add the
 device specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, yu1.wang@intel.com, conghui.chen@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/11/18 16:22, Paolo Bonzini wrote:
> On 18/11/20 03:06, Jie Deng wrote:
>> Can the "kick" be used for grouping ?=C2=A0 I mean when a write and a re=
ad
>> are sent by one kick at a time, they will be treated as one
>> transaction by default if the host has such a feature bit.
>
> No, the kick is only an advice.=C2=A0 The device is allowed to poll on th=
e=20
> ring and ignore kicks completely, for example.
>
> Paolo
>
Understood. But I saw your proposal can only group two segments=20
"write-read".
What if we have segments more than two ? for example,=20
"write-read-read..." or "write-write-write...".
Can we use a flag to tag the START/STOP segments so that they can be=20
grouped into one transaction ?

Thanks.



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

