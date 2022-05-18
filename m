Return-Path: <virtio-return-3777-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <e6446d40-9144-b615-b7ea-e807600b6aab@nvidia.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <e6446d40-9144-b615-b7ea-e807600b6aab@nvidia.com>
Date: Wed, 18 May 2022 15:50:51 +0200
Message-ID: <87leuzeypw.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-comment] Re: [PATCH v5 2/7] Introduce admin command set
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 18 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 5/15/2022 6:23 PM, Michael S. Tsirkin wrote:
>> On Wed, Apr 27, 2022 at 01:58:19AM +0300, Max Gurtovoy wrote:
>>> This command set is used for essential administrative and management
>>> operations.
>>>
>>> Admin commands should be submitted to a well defined management
>>> interface.
>>>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   admin.tex   | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   content.tex |   2 +
>>>   2 files changed, 125 insertions(+)
>>>   create mode 100644 admin.tex
>>>
>>> +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the driver to acknowledge those admin capabilities it understands and wishes to use.
>>
>> ok so we have a protocol here, kind of like feature negotiation. Please write its description.
>> e.g. is it ok to change accepted caps? when? can device change its caps
>> etc etc etc.
>
> I don't understand what does this mean to change a cap ?
>
> Device can offer a cap and driver can accept it if it wishes to use it.
>
> That is it.
>
> I added this mechanism just for your request.
>
> I never saw a device that asks acceptance from driver but I did my best 
> to fulfill your request.
>
>>
>> Avoiding this kind of spec work is exactly why me and jason keep telling
>> you to consider just using features instead. Add a 64 bit admin features
>> field to the PCI transport and be done with it. CCW and MMIO already
>> have feature selector so it's trivial to add feature bits.
>
> It's not scalable for admin mechanism and I don't want to perform 100 
> write/read from configuration space instead of doing all in 1 admin command.

Why use the config space for that; just use feature bits, there are
enough of those, and we already have a defined protocol.

>
>>
>>
>>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT by the driver.
>>> +
>>> +The command specific data set by the driver is of form:
>>> +\begin{lstlisting}
>>> +struct virtio_admin_device_caps_accept_data {
>>> +       /* Indicates which of the below fields were set
>>> +        * (1 means that field is set):
>>
>> yes we all know that 1 means set.
>>
>> do you really mean field is valid maybe?
> yes valid == set.
>>
>>
>>> +        * Bit 0 - driver_admin_caps
>>> +        * Bits 1 - 63 - reserved for future fields
>>> +        */
>>> +       le64 attrs_mask;
>> looks like going overboard. just send 64 caps bits and be done with it.
>> and rename accept_data to accept_caps.
> this is the command specific data.
>>
>>> +       /* This field indicates which of the below admin
>>> +        * capabilities are supported by the driver:
>>> +        * Bits 0 - 63 - reserved for future capabilities.
>>> +        */
>>> +       le64 driver_admin_caps;
>>> +       u8 reserved[112];
>>
>> I just noticed this. Please do not add this huge amount of padding
>> everywhere. instead, explain that device must be ready to accept
>> a smaller or larger buffer depending on feature bits.
>
> It's not huge. It's 128B command data.
>
> We will be sorry in the future for not doing extendable API.
>
> I prefer keep it 128B unless there is a concrete reason for not doing so.

So just use a variable length structure, that should be extendable for
all future use cases.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

