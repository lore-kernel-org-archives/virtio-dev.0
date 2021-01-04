Return-Path: virtio-comment-return-1618-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20201229110934.GA55616@stefanha-x1.localdomain>
 <b6267b12-4026-ec9b-5bec-155246b1cc00@intel.com>
 <20201230102037.GA87700@stefanha-x1.localdomain>
 <e5b8e645-083f-638a-69cc-f1b01c7a4dd0@intel.com>
 <20201231124242.GA134901@stefanha-x1.localdomain>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <f1cb44e5-d952-1d6c-f78c-875b9eb58809@intel.com>
Date: Mon, 4 Jan 2021 10:31:48 +0800
MIME-Version: 1.0
In-Reply-To: <20201231124242.GA134901@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/12/31 20:42, Stefan Hajnoczi wrote:
>
>>> This approach causes a bottleneck when there are multiple I2C devices.
>>> It requires exclusive access to the virtqueue and virtual I2C bus,
>>> slowing down applications that are accessing separate I2C devices.
>>>
>>> This is inefficient, especially if the I2C devices are emulated or on
>>> separate physical I2C busses where request concurrent processing is
>>> possible.
>>>
>>> This also creates starvation/denial-of-service problems in the driver
>>> because an application can submit many requests and needs exclusive
>>> access to the virtqueue until all requests have completed.
>>>
>>> I suggest defining a VIRTIO_I2C_FLAGS_CONTINUATION bit in struct
>>> virtio_i2c_out_hdr::flags. When a request fails and this flag is set
>>> then the device fails all later requests until it reaches a request
>>> where the flag is zero. This allows the driver to enqueue a sequence of
>>> requests that fail as a group without waiting for an empty virtqueue.
>> The flags is designed to be a "driver->device" field for extensibility. =
It
>> is read-only=EF=BF=BD to the device.
>> So when a request fails, the device can't set this read-only field.
> Sorry, "and this flag is set" means "and this flag was set by the
> driver". My intention was that the driver marks a request so the device
> knows that it needs to fail the next request too when this request
> fails.
No. A device doesn't need to be told by a driver if it needs to fail the=20
next request.
Actually just the opposite, a driver may need to be notified. A driver=20
can't know which
one is the "next" because only a device know which request is the first=20
failed one.

Once a device fails to handle a request, it shall fail the existing=20
remaining requests
since these requests needs to be handled in order.
> Thinking about it again, VIRTIO_I2C_FLAGS_FAIL_NEXT would be a clearer
> name for this flag.
>
>> We just need to make sure that once the driver adds some requests to the
>> virtqueue,
>> it should complete them (either success or fail) before adding new reque=
sts.
>> I think this
>> is a behavior of physical I2C adapter drivers and we can follow.
> Existing VIRTIO devices do not have special empty queue semantics and I
> don't think virtio-i2c should introduce a special case here. The
> VIRTIO_I2C_FLAGS_FAIL_NEXT flag is simple to implement, allows drivers
> more freedom to enqueue requests, and eliminates the race condition with
> polled device implementations (they could complete failed request #1
> before request #2 is enqueued and then request #2 would not be
> automatically failed).
The I2C core is using a synchronization semantics. It means once a I2C=20
bus driver send
some messages, it should wait for the device to complete them (either=20
success or fail)
before sending new messages. The virtio-i2c driver also have to follow=20
this to register it into
I2C subsystem. So the freedom is already limited by the I2C core, and as=20
a result, we don't have
such race conditions.

> Stefan

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

