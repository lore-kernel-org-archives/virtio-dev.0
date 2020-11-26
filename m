Return-Path: virtio-comment-return-1539-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201125125238.GT4077@smile.fi.intel.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <507a9179-a503-0f31-0670-0aff13638221@intel.com>
Date: Thu, 26 Nov 2020 10:58:59 +0800
MIME-Version: 1.0
In-Reply-To: <20201125125238.GT4077@smile.fi.intel.com>
Subject: [virtio-comment] Re: [PATCH v5] virtio-i2c: add the device specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/11/25 20:52, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
>> virtio-i2c is a virtual I2C adapter device. It provides a way
>> to =EF=AC=82exibly communicate with the host I2C slave devices from
>> the guest.
>>
>> This patch adds the specification for this device.
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/88
> Hmm... Is it used like this here, in this tree?
> I would rather expect BugLink:.

This is the rule of virtio-spec. It uses github issue to track the=20
development.

>> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ...
>
>> +virtio-i2c is a virtual I2C adapter device. It provides a way to flexib=
ly
>> +organize and use the host I2C slave devices from the guest. By attachin=
g
>> +the host ACPI I2C slave nodes to the virtual I2C adapter device, the gu=
est can
>> +communicate with them without changing or adding extra drivers for thes=
e
>> +slave I2C devices.
> Trailing white space.
Good catch. Thank you.

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

