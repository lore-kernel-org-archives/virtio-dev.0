Return-Path: virtio-comment-return-1558-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216183859.1e7b206a.cohuck@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <efe4a6a1-87f1-9712-fc87-6ee17edff6ae@intel.com>
Date: Thu, 17 Dec 2020 15:29:57 +0800
MIME-Version: 1.0
In-Reply-To: <20201216183859.1e7b206a.cohuck@redhat.com>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Thank you. I will fix them.

On 2020/12/17 1:38, Cornelia Huck wrote:
> On Wed, 25 Nov 2020 13:55:18 +0800
> Jie Deng <jie.deng@intel.com> wrote:
>
> <some mostly editorial comments; sorry about bringing this up now>
>
>> +
>> +A driver MUST place one segment of an I2C transaction into \field{write=
_buf} if the
>>
>> s/if the/if/
>>
>> +
>> +A device MUST place one segment of an I2C transaction into \field{read_=
buf} if the
> s/if/if the/

Do you mean=C2=A0 "s/if the/if/" here ?

>
> irst failed one to be VIRTIO_I2C_MSG_ERR.

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

