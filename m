Return-Path: <virtio-dev-return-9749-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5133F986350
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Aug 2022 09:54:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220809160711-mutt-send-email-mst@kernel.org>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-2-usama.arif@bytedance.com>
 <20220809160711-mutt-send-email-mst@kernel.org>
Date: Wed, 10 Aug 2022 11:54:35 +0200
Message-ID: <87r11octk4.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device auxiliary
 notifications
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Usama Arif <usama.arif@bytedance.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 09 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 30, 2022 at 04:21:02PM +0100, Usama Arif wrote:
>> Driver auxiliary notifications allow the device to send notifications
>> other than configuration changes and used buffer notifications to the
>> driver, these are optional and their meaning is device-specific.
>> 
>> Device auxiliary notifcations allow the driver to send notifcations
>> other than available buffer notifications to the device for example
>> through a device register, these are optional and their meaning is
>> device-specific.
>> 
>> These device-specific notifications are needed later when adding support
>> for virtio-vhost-user device.
>> 
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>
> I see ccw is missing. Cornelia, any suggestions?

Hmm... I seem to be really behind on ccw things :(

We can probably use the following:

- for device->driver notification, use the next bit in the secondary
  indicators (bit 0 is used for config change notification)
- for driver->device notification, maybe use a new subcode for diagnose
  0x500 (4 is probably the next free one?)

I have not looked at the requirements deeply, though.

This highlights another problem, however: When we introduce new features
that require a transport-specific implementation, we often end up with a
PCI implementation, but sometimes MMIO and more often ccw are left
behind -- which is understandable, as PCI is what most people use, and
ccw is something only a very few people are familiar with. This sadly
means that we have a backlog of features supported in PCI, but not in
ccw... requiring implementations for ccw would put an undue burden on
contributors, as most of them are unlikely to write anything for a
mainframe, ever. On the flip side, I do not have enough bandwith to deal
with all of this.

Halil, any thoughts (on any of the above)?

>
>> ---
>>  content.tex | 35 ++++++++++++++++++++++-------------
>>  1 file changed, 22 insertions(+), 13 deletions(-)
>> 
>> diff --git a/content.tex b/content.tex
>> index c6f116c..85980ac 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -160,29 +160,38 @@ \subsection{Legacy Interface: A Note on Feature
>>  Specification text within these sections generally does not apply
>>  to non-transitional devices.
>>  
>> -\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
>> -/ Notifications}
>> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device / Notifications}
>>  
>>  The notion of sending a notification (driver to device or device
>>  to driver) plays an important role in this specification. The
>>  modus operandi of the notifications is transport specific.
>>  
>> -There are three types of notifications: 
>> +There are five types of notifications:
>>  \begin{itemize}
>>  \item configuration change notification
>>  \item available buffer notification
>> -\item used buffer notification. 
>> +\item used buffer notification
>> +\item driver auxiliary notification
>> +\item device auxiliary notification
>>  \end{itemize}
>>  
>> -Configuration change notifications and used buffer notifications are sent
>> -by the device, the recipient is the driver. A configuration change
>> -notification indicates that the device configuration space has changed; a
>> -used buffer notification indicates that a buffer may have been made used
>> -on the virtqueue designated by the notification.
>> -
>> -Available buffer notifications are sent by the driver, the recipient is
>> -the device. This type of notification indicates that a buffer may have
>> -been made available on the virtqueue designated by the notification.
>> +Configuration change notifications, used buffer notifications and
>> +driver auxiliary notifications are sent by the device,
>> +the recipient is the driver. A configuration change notification indicates
>> +that the device configuration space has changed; a used buffer notification
>> +indicates that a buffer may have been made used on the virtqueue designated
>> +by the notification; driver auxiliary notifications allow the
>> +device to send notifications other than configuration changes and used
>> +buffer notifications to the driver, these are optional and their meaning
>> +is device-specific.
>> +
>> +Available buffer notifications and device auxiliary notifications
>> +are sent by the driver, the recipient is the device. Available buffer
>> +notifications indicate that a buffer may have been made available on the
>> +virtqueue designated by the notification; device auxiliary
>> +notifcations allow the driver to send notifcations other than available
>> +buffer notifications to the device for example through a device register, these
>> +are optional and their meaning is device-specific.
>>  
>>  The semantics, the transport-specific implementations, and other
>>  important aspects of the different notifications are specified in detail
>> -- 
>> 2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

