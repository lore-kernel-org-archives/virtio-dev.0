Return-Path: virtio-dev-return-7594-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 469EA9860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 16:02:21 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-4-ndragazis@arrikto.com>
 <20200717093457.GD128195@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <2561d1a2-e57d-cab5-0fe5-7394bb6032ce@arrikto.com>
Date: Fri, 17 Jul 2020 19:02:18 +0300
MIME-Version: 1.0
In-Reply-To: <20200717093457.GD128195@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 03/10] vhost-user: add requirements for
 the notification capability
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/7/20 12:34 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:

> On Mon, May 18, 2020 at 11:37:14PM +0300, Nikos Dragazis wrote:
>> The configuration structure for the notification capability has certain
>> device/driver requirements, similar to those of the MSI-X vector
>> configuration. Add these requirements to the device spec.
>>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   virtio-vhost-user.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>> index 13ecd41..7a8cd9c 100644
>> --- a/virtio-vhost-user.tex
>> +++ b/virtio-vhost-user.tex
>> @@ -275,6 +275,48 @@ \subsubsection{Notification structure layout}\label=
{sec:Device Types / Vhost-use
>>   \field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to ch=
ange the
>>   MSI-X vector for that notification.
>>  =20
>> +\devicenormative{\paragraph}{Notification capability}{Device Types / Vh=
ost-user Device Backend / Additional Device Resources over PCI / Notificati=
on capability}
>> +
>> +If MSI-X is available, device MUST support mapping any master queue
>> +event to any valid vector 0 to MSI-X \field{Table Size}. Here
> This section combines two things:
> 1. vhost-user concepts -> VIRTIO notifications
> 2. VIRTIO notifications -> VIRTIO PCI transport MSI-X implementation of
>     notifications
>
> I think this should be split:
> 1. The virtio-vhost-user device spec should explain that vhost-user queue
>     events are mapped to VIRTIO notifications
> 2. The PCI transport spec should explain how notifications are mapped to
>     MSI-X
>
> This way other VIRTIO device types will be able to use notifications too
> without everyone explaining MSI-X specifics. Also it won't tie
> virtio-vhost-user to VIRTIO PCI.

If I understand correctly, you are suggesting that we should standardize
the notification resource, similarly to the shared memory resource, so
that any device can use it. Is that so?

>
>> +\field{Table Size} is the \field{N-1} encoded Table Size stored in the
>> +Message Control register of the MSI-X capability structure according to
>> +\hyperref[intro:PCI]{[PCI]}, where \field{N} is the actual MSI-X Table
>> +Size.
>> +
>> +Device MUST support unmapping any master queue event.
>> +
>> +The device MUST return vector mapped to a given master queue event,
>> +(\field{NO_VECTOR} if unmapped) on read of
>> +\field{notification_msix_vector}. The device MUST have all master queue
>> +events unmapped upon reset.
> "The device MUST unmap all master queue events upon reset" is clearer in
> indicating that the device must take this action.

ACK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

