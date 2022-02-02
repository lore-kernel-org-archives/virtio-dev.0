Return-Path: <virtio-dev-return-9245-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FC58986609
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Feb 2022 11:52:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <f8b0ea37-8721-5ca4-f6d7-37770728beec@nvidia.com>
References: <20220114111210.129059-1-cohuck@redhat.com>
 <f8b0ea37-8721-5ca4-f6d7-37770728beec@nvidia.com>
Date: Wed, 02 Feb 2022 12:52:38 +0100
Message-ID: <8735l1xz7d.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] Reserve more feature bits for device type usage
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 02 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 1/14/2022 1:12 PM, Cornelia Huck wrote:
>> Feature bits 41 and above are noted as being reserved for future
>> extensions. However, the net device has been using bits in that space
>> for some time now, as it already used up the device type specific
>> range up to 23.
>>
>> To avoid problems in the future, let's designate bits 50 to 127 to
>> device type specific usage (which accommodates current usage by the
>> net driver, and gives breathing room for future type specific bits),
>> and declare bits 41 to 49 and bits 128 and above to be reserved for
>> future extensions (which gives us some time before bit numbers move
>> beyond 63, which would need some changes in existing device and driver
>> implementations.)
>>
>> Reported-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/131
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   content.tex | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index 32de6685c50b..c6f116c7aa39 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -97,12 +97,12 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>>   Feature bits are allocated as follows:
>>   
>>   \begin{description}
>> -\item[0 to 23] Feature bits for the specific device type
>> +\item[0 to 23, and 50 to 127] Feature bits for the specific device type
>>   
>>   \item[24 to 40] Feature bits reserved for extensions to the queue and
>>     feature negotiation mechanisms
>>   
>> -\item[41 and above] Feature bits reserved for future extensions.
>> +\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
>>   \end{description}
>>   
>>   \begin{note}
>
> Cornelia,
>
> I've noticed that Legacy net device has VIRTIO_NET_F_GUEST_RSC4 (41) and 
> VIRTIO_NET_F_GUEST_RSC6 (42).
>
> Do we need to reserved them too or keep the fix as-is ?

Eww. I think those bits shouldn't have been hiding in the "legacy"
section, as their higher number indicates that they are not for a legacy
device in the spec sense.

They have been introduced in
https://github.com/oasis-tcs/virtio-spec/issues/21 in 2018, I'm
wondering how old those Windows drivers referred to in there are. IOW,
would a new feature bit 41/42 break things for currently used Windows
drivers if it showed up on a virtio-net device? If we still care about
those drivers, we should reserve bits 41 and 42 as do-not-use, I guess.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

