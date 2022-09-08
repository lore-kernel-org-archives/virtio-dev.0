Return-Path: <virtio-comment-return-3445-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <6ba1c7ac-01b8-c4ba-5e24-28c88eab20ff@opensynergy.com>
Date: Thu, 8 Sep 2022 19:36:36 +0200
References: <20220908083044.95376-1-mst@redhat.com>
 <87sfl2s01f.fsf@redhat.com> <20220908070923-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>
In-Reply-To: <20220908070923-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio] Re: [virtio-dev] [PATCH] audio->sound
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 08.09.22 13:09, Michael S. Tsirkin wrote:
> On Thu, Sep 08, 2022 at 11:11:40AM +0200, Cornelia Huck wrote:
>> On Thu, Sep 08 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> Spec calls the device "sound device". Make the name in the
>>> ID section match.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>   content.tex | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index 5c66e6b..279998a 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3014,7 +3014,7 @@ \chapter{Device Types}\label{sec:Device Types}
>>>   \hline
>>>   24         &   Memory device \\
>>>   \hline
>>> -25         &   Audio device \\
>>> +25         &   Sound device \\
>>>   \hline
>>>   26         &   file system device \\
>>>   \hline
>>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>
>> Actually, under the title "Sound device", the spec says
>>
>> "The virtio sound card is a virtual audio device..."
>>
>> -- should it be "virtio sound device" instead?
>=20
> I don't know, leave that for audio experts ;)

I'll pretend to be one, and as far as I can remember audio is only the=20
sounds in the audible range (few Hz to 20kHz) but SOUND can go below and=20
above that in frequency (ultrasonic for example). It's an elaborate form=20
of bike shedding if you ask me, but the 'real experts(tm)' claim that=20
there's a huge difference.

As for the change, it looks fine to me. It makes the naming consistent=20
across the chapters and doesn't exclude inaudible tones.

Reviewed-By: Matti M=C3=B6ll <Matti.Moell@opensynergy.com>

--=20
OpenSynergy GmbH

Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 =E2=80=93 54

Fax:      +49 30 60 98 54 0 -99

EMail: matti.moell@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B

Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah

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

