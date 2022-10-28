Return-Path: <virtio-dev-return-10095-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA90D9866FC
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Oct 2022 10:06:03 +0000 (UTC)
Message-ID: <11ebb41b-1dcb-bfe8-af5f-8db1cdce0e4b@bytedance.com>
Date: Fri, 28 Oct 2022 11:05:59 +0100
MIME-Version: 1.0
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-2-usama.arif@bytedance.com> <Y1rkiivA9J0KXr3U@fedora>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <Y1rkiivA9J0KXr3U@fedora>
Subject: [virtio-dev] Re: [External] Re: [PATCH v3 1/4] content: Introduce driver/device
 auxiliary notifications
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 27/10/2022 21:05, Stefan Hajnoczi wrote:
> On Fri, Oct 07, 2022 at 05:56:40PM +0100, Usama Arif wrote:
>> Driver auxiliary notifications allow the device to send notifications
>> other than configuration changes and used buffer notifications to the
>> driver, these are optional and their meaning is device-specific.
>>
>> Device auxiliary notifications allow the driver to send notifications
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
>> ---
>>   content.tex | 35 ++++++++++++++++++++++-------------
>>   1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index e863709..49f9f2a 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -160,29 +160,38 @@ \subsection{Legacy Interface: A Note on Feature
>>   Specification text within these sections generally does not apply
>>   to non-transitional devices.
>>   
>> -\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
>> -/ Notifications}
>> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device / Notifications}
>>   
>>   The notion of sending a notification (driver to device or device
>>   to driver) plays an important role in this specification. The
>>   modus operandi of the notifications is transport specific.
>>   
>> -There are three types of notifications:
>> +There are five types of notifications:
>>   \begin{itemize}
>>   \item configuration change notification
>>   \item available buffer notification
>> -\item used buffer notification.
>> +\item used buffer notification
>> +\item driver auxiliary notification
>> +\item device auxiliary notification
>>   \end{itemize}
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
> 
> The meaning of "optional" is confusing and I suggest dropping it.
> 
> Auxiliary notifications are not used by all device types. In that sense
> they are "optional".
> 
> But a device types that do use them, like virtio-vhost-user, may require
> them. You cannot implement a virtio-vhost-user device without auxiliary
> notifications, so they are mandatory (not "optional") for that device
> type.
> 
> Finally, it is also possible for a device type to define a feature bit
> that enables auxiliary notifications. Drivers/devices that don't support
> auxiliary notifications leave the feature bit cleared and still work
> properly. In this case they are truly "optional".
> 
> "Optional" is confusing. Just saying "their meaning is device-specific"
> is enough.
> 

Hi,

Yes agreed, it could be the case that auxiliary notifications are 
necessary for certain devices like VVU, so adding optional here can be 
confusing.

Will drop optional in next revision.

Thanks

>> +
>> +Available buffer notifications and device auxiliary notifications
>> +are sent by the driver, the recipient is the device. Available buffer
>> +notifications indicate that a buffer may have been made available on the
>> +virtqueue designated by the notification; device auxiliary
>> +notifications allow the driver to send notifications other than available
>> +buffer notifications to the device for example through a device register, these
>> +are optional and their meaning is device-specific.
>>   
>>   The semantics, the transport-specific implementations, and other
>>   important aspects of the different notifications are specified in detail
>> -- 
>> 2.25.1
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

