Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <5db67816-b377-0367-0b47-72f3024f004f@nvidia.com>
Date: Wed, 6 Jul 2022 14:25:52 +0300
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org>
 <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com> <87o7zvezkc.fsf@redhat.com>
 <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
 <CACGkMEsLRf+6PR8s0Vo2cv4ScMLBECtY+zDC2TSuov5NtPJVHQ@mail.gmail.com>
 <20220602024254-mutt-send-email-mst@kernel.org>
 <58349984-d638-31af-82e5-8cb0fff6b0fb@nvidia.com>
 <20220628144422-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220628144422-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 6/28/2022 9:54 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 28, 2022 at 12:52:51AM +0300, Max Gurtovoy wrote:
>> On 6/2/2022 9:59 AM, Michael S. Tsirkin wrote:
>>> On Thu, Jun 02, 2022 at 10:21:23AM +0800, Jason Wang wrote:
>>>> On Wed, Jun 1, 2022 at 9:44 PM Max Gurtovoy <mgurtovoy@nvidia.com> wro=
te:
>>>>> On 5/18/2022 4:32 PM, Cornelia Huck wrote:
>>>>>> On Wed, May 18 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>>
>>>>>>> Hi MST,
>>>>>>>
>>>>>>> On 5/15/2022 6:25 PM, Michael S. Tsirkin wrote:
>>>>>>>> On Wed, Apr 27, 2022 at 01:58:18AM +0300, Max Gurtovoy wrote:
>>>>>>>>> +\subsection{Device group}\label{sec:Introduction / Terminology /=
 Device group}
>>>>>>>>> +
>>>>>>>>> +A device group includes one or more virtio devices.
>>>>>>>>> +Each virtio device has a unique virtio device id (vdev_id) withi=
n a device group. A valid vdev_id is a 64-bit field in the range of
>>>>>>>>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value =
that refers to all devices in a device group and isn't a valid vdev_id.
>>>>>>>>> +
>>>>>>>>> +For now, the supported device groups are:
>>>>>>>>> +\begin{enumerate}
>>>>>>>>> +\item Type 1 - A virtio PCI SR-IOV physical function (PF) and it=
s PCI SR-IOV virtual functions (VFs). For this group type, the PF device ha=
s vdev_id that is equal to 0
>>>>>>>>> +and the VF devices have vdev_id's that are equal to their vf_num=
ber (according to the PCI SR-IOV specification).
>>>>>>>>> +\end{enumerate}
>>>>>>>>> +
>>>>>>>>>      \section{Structure Specifications}\label{sec:Structure Speci=
fications}
>>>>>>>> In context of virtualization type 1 already refers to a specific t=
ype
>>>>>>>> of hypervisor.
>>>>>>>>
>>>>>>>> I suggest simply "SR-IOV type" - this way users do not need to rem=
ember
>>>>>>>> special terminology.
>>>>>>> This is 12 lines addition commit with simple definition.
>>>>>>>
>>>>>>> I didn't mentioned hypervisors here.
>>>>>>>
>>>>>>> I will stick to your suggestion and use name instead of numbers
>>>>>>> (although I don't understand how can a use that knows how to read s=
pec
>>>>>>> will be confused here), but I would like Jason and Cornelia to ack =
on
>>>>>>> this during this review cycle.
>>>>>>>
>>>>>>> When we'll get 3 acks on this name - I'll update it for v6.
>>>>>> So, do you want to imply some kind of numbering? I don't like "Type =
1",
>>>>>> either. If the type needs to be referenced in code, it should have a
>>>>>> #define or such; otherwise, "SR-IOV type" would be fine.
>>>>> ok I'll change it to be:
>>>>>
>>>>> diff --git a/introduction.tex b/introduction.tex
>>>>> index aa9ec1b..bba70a6 100644
>>>>> --- a/introduction.tex
>>>>> +++ b/introduction.tex
>>>>> @@ -156,6 +156,18 @@ \subsection{Transition from earlier specificatio=
n
>>>>> drafts}\label{sec:Transition f
>>>>>     sections tagged "Legacy Interface" in the section title.
>>>>>     These highlight the changes made since the earlier drafts.
>>>>>
>>>>> +\subsection{Device group}\label{sec:Introduction / Terminology / Dev=
ice
>>>>> group}
>>>>> +
>>>>> +A device group includes one or more virtio devices.
>>>>> +Each virtio device has a unique virtio device id (vdev_id) within a
>>>>> device group. A valid vdev_id is a 64-bit field in the range of
>>>>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that
>>>>> refers to all devices in a device group and isn't a valid vdev_id.
>>> BTW I don't really like inventing terms with underscores.
>>> Let's stick to english if we can. By the way "id" is not a word, either
>>> ;) We have a couple of instances which we really should fix.
>>> And "virtio device id" is confusingly similar to
>>> virtio "device id" where device id is a term from pci.
>>> And abbreviations really should be capitalized or end with a comma
>>> but really best just avoided.
>>>
>>> How about group member identifier? So
>>>
>>> Each virtio device within a group has a unique member identifier.
>>>
>>>
>>>
>>>>> +
>>>>> +For now, the supported device groups are:
>>>>> +\begin{enumerate}
>>>>> +\item SR-IOV type - A virtio PCI SR-IOV physical function (PF) and i=
ts
>>>>> PCI SR-IOV virtual functions (VFs). For this group type, the PF devic=
e
>>>>> has vdev_id that is equal to 0
>>>>> +and the VF devices have vdev_id's that are equal to their vf_number
>>>>> (according to the PCI SR-IOV specification).
>>> A bit better just from grammar perspective:
>>>
>>>    \item SR-IOV type - the group includes a virtio PCI SR-IOV physical =
function (PF) and
>>>    all its virtual functions (VFs). For this group type, the PF device
>>>    has vdev_id of 0;
>>>    each VF has a vdev_id matching it's VF number [link to SRIOV spec].
>>>
>>> but note ideas on terminology above.
>> update to:
>>
>> "
>>
>> +\subsection{Device group}\label{sec:Introduction / Terminology / Device
>> group}
>> +
>> +A device group includes one or more virtio devices.
>> +Each virtio device has a unique group member identifier (group_member_i=
d)
>> within a device group. A valid group member identifier
>> +is a 64-bit field in the range of 0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id
> Vdev_id -> member identifier ?

Yea thanks.

>
>> 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a
>> +device group and isn't a valid group member identifier.
>> +
>> +For now, the supported device groups are:
>> +\begin{enumerate}
>> +\item SR-IOV type - this group includes a virtio PCI SR-IOV physical
>> function (PF) and all its virtual functions (VFs).
>> +For this group type, the PF device has group member identifier of 0. Ea=
ch
>> VF has a group member identifier matching it's VF number
>> +(according to PCI Express Base Specification, Single Root I/O
>> Virtualization and Sharing chapter).
>> +\end{enumerate}
>>
>> "
>>
>> It's 90% suggested by MST.
>>
>>>>> +\end{enumerate}
>>>>> +
>>>>>     \section{Structure Specifications}\label{sec:Structure Specificat=
ions}
>>>>>
>>>>> MST/Jason/Cornelia,
>>>>>
>>>>> can you add some Reviewed-By signatures if the above is agreed ?
>>>> If I understand this correctly, the idea of "device group" is to allow
>>>> different groups to be managed by a single admin virtqueue?
>>>>
>>>> And I feel that mixing transport specific definitions in the general
>>>> admin virtqueue might not be optimal. So I wonder whether it's better
>>>> to just say this is a transport specific type. And define it in the
>>>> PCI transport part.
>>>>
>>>> Thanks
>>> Well it's a single paragraph here, I think it's ok for now for complete=
ness
>>> sake rather than have reader chase references just to figure out an
>>> example.
>>>
>>> But I do agree this sentence about SRIOV type has to be repeated
>>> in the pci transport section for completeness of that one.
>>>
>> Please suggest exactly what to add and where to add it.
>>
>> And it will be done in V6.
>
> maybe add here "devices of this type use the Virtio PCI transport
> (link)"
>
> I am not sure. Maybe we want a section about SR-IOV generally,
> with mentions of the feature bit and the group type.
> For now I think what you have is enough.

Ok.

So for now we won't=C2=A0 add this.

>
>>>>>
>>>>>> This publicly archived list offers a means to provide input to the
>>>>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>>>>
>>>>>> In order to verify user consent to the Feedback License terms and
>>>>>> to minimize spam in the list archive, subscription is required
>>>>>> before posting.
>>>>>>
>>>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>>>>> List help: virtio-comment-help@lists.oasis-open.org
>>>>>> List archive: https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=
=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43=
083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C3000%7C%7C%7C&amp;sdata=3D0XwN3pTAYNhgJFRuqALYtVBThDCllyIqodB%2FKWUQ60g%=
3D&amp;reserved=3D0
>>>>>> Feedback License: https://nam11.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp=
;data=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162=
%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2BGL0fb%2BXCfyJgYd1yWHnvB8W0sftmUqkIkzau=
EMhdLo%3D&amp;reserved=3D0
>>>>>> List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&a=
mp;data=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a1=
62%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DLW1vxwUQ06I91v01WYDQ4xlMcuwFPsuhSqGhPj5=
%2BAIA%3D&amp;reserved=3D0
>>>>>> Committee: https://nam11.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=3D05%7C01%7=
Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15727340=
c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7=
C%7C&amp;sdata=3D19ZQLm0hS7EFuvqW2W9irntVceUFXn9PwixmsoGoq24%3D&amp;reserve=
d=3D0
>>>>>> Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=3D05%7C01%7Cmgurtovoy%40n=
vidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15727340c1b7db39efd9cc=
c17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3DJ0Ar7y7sfs15LYzCU%2F7hYsQr0k2UEDEH4Ae%2BAUjn9RU%3D&amp;reserved=3D0
>>>>>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=3D05=
%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d1=
5727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3D0XwN3pTAYNhgJFRuqALYtVBThDCllyIqodB%2FKWUQ60g%3D&am=
p;reserved=3D0
>> Feedback License: https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp;dat=
a=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C4=
3083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C3000%7C%7C%7C&amp;sdata=3D%2BGL0fb%2BXCfyJgYd1yWHnvB8W0sftmUqkIkzauEMhd=
Lo%3D&amp;reserved=3D0
>> List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&amp;d=
ata=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7=
C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C3000%7C%7C%7C&amp;sdata=3DLW1vxwUQ06I91v01WYDQ4xlMcuwFPsuhSqGhPj5%2BA=
IA%3D&amp;reserved=3D0
>> Committee: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=3D05%7C01%7Cmgu=
rtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15727340c1b7=
db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C=
&amp;sdata=3D19ZQLm0hS7EFuvqW2W9irntVceUFXn9PwixmsoGoq24%3D&amp;reserved=3D=
0
>> Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=3D05%7C01%7Cmgurtovoy%40nvidi=
a.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15727340c1b7db39efd9ccc17a=
%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DJ=
0Ar7y7sfs15LYzCU%2F7hYsQr0k2UEDEH4Ae%2BAUjn9RU%3D&amp;reserved=3D0
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=3D05%=
7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15=
727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300=
0%7C%7C%7C&amp;sdata=3D0XwN3pTAYNhgJFRuqALYtVBThDCllyIqodB%2FKWUQ60g%3D&amp=
;reserved=3D0
> Feedback License: https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp;data=
=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43=
083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C3000%7C%7C%7C&amp;sdata=3D%2BGL0fb%2BXCfyJgYd1yWHnvB8W0sftmUqkIkzauEMhdL=
o%3D&amp;reserved=3D0
> List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&amp;da=
ta=3D05%7C01%7Cmgurtovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C=
43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C3000%7C%7C%7C&amp;sdata=3DLW1vxwUQ06I91v01WYDQ4xlMcuwFPsuhSqGhPj5%2BAI=
A%3D&amp;reserved=3D0
> Committee: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=3D05%7C01%7Cmgur=
tovoy%40nvidia.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15727340c1b7d=
b39efd9ccc17a%7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&=
amp;sdata=3D19ZQLm0hS7EFuvqW2W9irntVceUFXn9PwixmsoGoq24%3D&amp;reserved=3D0
> Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=3D05%7C01%7Cmgurtovoy%40nvidia=
.com%7Cf8b3fbba2f4d48340b2908da5937a162%7C43083d15727340c1b7db39efd9ccc17a%=
7C0%7C0%7C637920392844378366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DJ0=
Ar7y7sfs15LYzCU%2F7hYsQr0k2UEDEH4Ae%2BAUjn9RU%3D&amp;reserved=3D0
>

