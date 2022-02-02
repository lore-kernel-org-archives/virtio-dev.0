Return-Path: <virtio-comment-return-2706-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <d9bb4416-90ad-4bba-adfa-027cdd114bb4@nvidia.com>
References: <20220114111210.129059-1-cohuck@redhat.com>
 <f8b0ea37-8721-5ca4-f6d7-37770728beec@nvidia.com>
 <8735l1xz7d.fsf@redhat.com>
 <d9bb4416-90ad-4bba-adfa-027cdd114bb4@nvidia.com>
Date: Wed, 02 Feb 2022 13:21:19 +0100
Message-ID: <87zgn9wjb4.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH] Reserve more feature bits for device type usage
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 02 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 2/2/2022 1:52 PM, Cornelia Huck wrote:
>> On Wed, Feb 02 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>>> On 1/14/2022 1:12 PM, Cornelia Huck wrote:
>>>> Feature bits 41 and above are noted as being reserved for future
>>>> extensions. However, the net device has been using bits in that space
>>>> for some time now, as it already used up the device type specific
>>>> range up to 23.
>>>>
>>>> To avoid problems in the future, let's designate bits 50 to 127 to
>>>> device type specific usage (which accommodates current usage by the
>>>> net driver, and gives breathing room for future type specific bits),
>>>> and declare bits 41 to 49 and bits 128 and above to be reserved for
>>>> future extensions (which gives us some time before bit numbers move
>>>> beyond 63, which would need some changes in existing device and driver
>>>> implementations.)
>>>>
>>>> Reported-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/131
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>    content.tex | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 32de6685c50b..c6f116c7aa39 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -97,12 +97,12 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>>>>    Feature bits are allocated as follows:
>>>>    
>>>>    \begin{description}
>>>> -\item[0 to 23] Feature bits for the specific device type
>>>> +\item[0 to 23, and 50 to 127] Feature bits for the specific device type
>>>>    
>>>>    \item[24 to 40] Feature bits reserved for extensions to the queue and
>>>>      feature negotiation mechanisms
>>>>    
>>>> -\item[41 and above] Feature bits reserved for future extensions.
>>>> +\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
>>>>    \end{description}
>>>>    
>>>>    \begin{note}
>>> Cornelia,
>>>
>>> I've noticed that Legacy net device has VIRTIO_NET_F_GUEST_RSC4 (41) and
>>> VIRTIO_NET_F_GUEST_RSC6 (42).
>>>
>>> Do we need to reserved them too or keep the fix as-is ?
>> Eww. I think those bits shouldn't have been hiding in the "legacy"
>> section, as their higher number indicates that they are not for a legacy
>> device in the spec sense.
>>
>> They have been introduced in
>> https://github.com/oasis-tcs/virtio-spec/issues/21 in 2018, I'm
>> wondering how old those Windows drivers referred to in there are. IOW,
>> would a new feature bit 41/42 break things for currently used Windows
>> drivers if it showed up on a virtio-net device? If we still care about
>> those drivers, we should reserve bits 41 and 42 as do-not-use, I guess.
>
> I've not idea about the windows drivers.
>
> But the bit 41 is currently the bit I use to negotiate the AQ in the 
> last patchset so we need to decide how to progress.

For your purpose, it would probably be best to simply go with 43 in your
next update.

We have to come to a conclusion before we merge any new feature using a
bit in that range anyway... and I really would like to have that cleared
up before we do our draft :/


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

