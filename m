Return-Path: <virtio-dev-return-9596-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BC9F98674B
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jun 2022 20:53:51 +0000 (UTC)
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3721.0.2\))
From: Patrick Mosca <pmosca@apple.com>
In-reply-to: <20220605162839-mutt-send-email-mst@kernel.org>
Date: Thu, 16 Jun 2022 13:53:38 -0700
Message-id: <F7C60FF0-08AC-4C61-B9C3-85C161818DE5@apple.com>
References: <6355541D-E117-4E7F-B5D9-3CD0028ED7FF@apple.com>
 <20220605162839-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Clarification of VIRTIO_F_EVENT_IDX driver conditions.
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cameron Esfahani <dirty@apple.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The issue may trigger in the unlikely uint16_t overflow case of computing t=
he difference between two index positions. An example would be a network dr=
iver where the host and guest are producing and consuming steadily but at d=
ifferent rates. The producer is producing faster than the consumer such tha=
t the consumer never needed to be notified of new events, as it is still pl=
aying catch up processing the queue.

If the producer finally catches up to the consumer and the catchup occurs j=
ust past the overflow point, there exists a case where a notification must =
be sent but is not sent according to the current ruleset.=20

-Patrick Mosca

> On Jun 5, 2022, at 1:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 01, 2022 at 01:03:27PM -0700, Patrick Mosca wrote:
>> We ran into an edge case in the VIRTIO_F_EVENT_IDX feature where a notif=
ication could be missed if there is a "streak" in skipped notifications. If=
 the difference between the event index and available index wraps before a =
notification is needed, there exists a case where a notification must be se=
nt but is not sent.
>>=20
>>=20
>> Signed-off-by: Patrick Mosca <pmosca@apple.com>
>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>> ---
>> split-ring.tex | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/split-ring.tex b/split-ring.tex
>> index bfef62d..9650e5e 100644
>> --- a/split-ring.tex
>> +++ b/split-ring.tex
>> @@ -530,6 +530,9 @@ \subsection{Available Buffer Notification Suppressio=
n}\label{sec:Basic Facilitie
>>         \item If the \field{idx} field in the available ring (which dete=
rmined
>>           where that descriptor index was placed) was equal to
>>           \field{avail_event}, the driver MUST send a notification.
>> +        \item If the number of descriptors added to the queue since
>> +          the last notification is greater than 65535, the driver MUST
>> +          send a notification.
>>         \item Otherwise the driver SHOULD NOT send a notification.
>>   \end{itemize}
>> \end{itemize}
>> --=20
>> 2.32.0 (Apple Git-131)
>>=20
>>=20
>> -Patrick Mosca
>=20
> I am not sure I understand. Can you give an example of how the issue
> triggers please?
>=20
> --=20
> MST
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

