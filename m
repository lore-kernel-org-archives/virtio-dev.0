Return-Path: virtio-comment-return-1513-cohuck=redhat.com@lists.oasis-open.org
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
From: Jie Deng <jie.deng@intel.com>
Message-ID: <c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com>
Date: Fri, 13 Nov 2020 10:39:10 +0800
MIME-Version: 1.0
In-Reply-To: <20201112035331-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH v4] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, yu1.wang@intel.com, conghui.chen@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/11/12 16:54, Michael S. Tsirkin wrote:
> On Thu, Nov 12, 2020 at 09:51:17AM +0800, Jie Deng wrote:
>> On 2020/11/10 18:59, Paolo Bonzini wrote:
>>> On 10/11/20 11:33, Michael S. Tsirkin wrote:
>>>>> Sorry I didn't reply last week, but I really would prefer if virtio-i=
2c
>>>>> supported write-read transactions.
>>>> And I think an easier way is to allow multi-segment transactions
>>>> probably using the stop flag.
>>> You cannot always be sure that the host would support them (with the
>>> exception of write+read transactions, which are pretty much universal),
>>> so you would also need to describe what the host features are.
>>>
>>> Paolo
>>>
>> Then I will send v5 to support write+read transactions using Paolo's
>> proposal.
>> I think we may have a simple version merged first and then improve it
>> according
>> to the actual needs.
>>
>> Thank you.
> I frankly don't get it, you put read/write flags there even though they
> are not needed, saying it's intended to mirror Linux, then don't want to
> put STOP there even though this is exactly what Linux has ...

Personally, I intended to mirror the Linux=C2=A0 "i2c_msg" to have followin=
g=20
interface.

struct virtio_i2c_req {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 addr;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 flags;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 len;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 buf[];
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 status;

};

I intended to implement the standard rules for I2C transactions
(no I2C_FUNC_PROTOCOL_MANGLING) for the first step. So in the
v1~v3 only the "I2C_M_RD" was used and other bits of the flags were=20
reserved.
(I2C_M_STOP requires I2C_FUNC_PROTOCOL_MANGLING).

For me, I intend to mirror the "i2c_msg" from the Linux completely.

I learned about Michael also intends to keep above interface but want to
remove some unnecessary bit (e.g. I2C_M_RD) from the flags (Correct me=20
if not right).

Paolo prefers following interface without flags.

struct virtio_i2c_req {
=09le16 addr;
=09le16 written;
=09le16 read;
=09u8 bufwrite[];
=09u8 status;
=09u8 bufread[];
};

So Michael and Paolo, I hope we can agree on the interface first.

Any suggestions ?

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

