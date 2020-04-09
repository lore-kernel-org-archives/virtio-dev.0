Return-Path: virtio-comment-return-1176-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20200227113735.23605-1-peter.hilber@opensynergy.com>
 <20200317192053.15665-1-peter.hilber@opensynergy.com>
 <87369tn2a4.fsf@linaro.org>
Message-ID: <f07872a9-d35f-307c-49ad-31b396fcc7d9@opensynergy.com>
Date: Thu, 9 Apr 2020 10:01:28 +0200
MIME-Version: 1.0
In-Reply-To: <87369tn2a4.fsf@linaro.org>
Content-Language: en-US
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v3] Add virtio SCMI device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: virtio-comment@lists.oasis-open.org, linux-arm-kernel@lists.infradead.org, Souvik.Chakravarty@arm.com, Sudeep.Holla@arm.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

apologies for my slow reply. Please find my answers below.

On 27.03.20 18:19, Alex Benn=C3=A9e wrote:
> <snip>
>> +
>> +\subsubsection{Shared Memory Operation}
>> +
>> +Various SCMI protocols define statistics shared memory regions (for
>> +statistics and sensor values).
>> +
>> +\devicenormative{\paragraph}{Shared Memory Operation}{Device Types / SC=
MI Device / Device Operation / Shared Memory Operation}
>> +
>> +If VIRTIO_SCMI_F_SHARED_MEMORY was negotiated, the device MAY implement
>> +an SCMI statistics shared memory region using a virtio shared memory
>> +region.
>=20
> AFAICT this is the first usage of shmid in the virtio spec so I have
> some questions. The spec says:

The File System Device, which has been added to the virtio-spec master
at least, also uses shared memory for the DAX Window already.[1]

>=20
>   Memory consistency rules vary depending on the region and the device
>   and they will be specified as required by each device.
>=20
> So what are the rules for memory consistency for these regions:
>=20
>   - are they read-only w.r.t the guest? (maybe this is implicit?)

The Arm SCMI spec[2] (DEN0056B) only lists "statistics" shared memory
(SHM) fields which are read-only to the guest (SCMI agent), although
this is not stated explicitly. I think the virtio spec should not
specify more about this.

>   - how does the guest know when they have been updated?

SCMI provides notification messages for some events. DEN0056B does not
specify any generic SHM update detection mechanism or SHM access
synchronization mechanism, so I would again say the virtio spec
should not specify anything about this.

>   - how goes the guest know it hasn't read a value mid-update?

I would add the following requirements (paraphrased) to the next virtio
SCMI device spec patch:

- All SHM elements MUST be naturally aligned.
- Read and write accesses to scalar elements in the SHM MUST be atomic.

Apart from this, I think DEN0056B imposes no further memory consistency
rules which the virtio SCMI device spec needs to address.

Best regards,

Peter


[1]
https://github.com/oasis-tcs/virtio-spec/blob/0c0dd715152cbbdc1d87e8d193d4c=
56d2b0bb5fe/virtio-fs.tex#L182
[2]
https://static.docs.arm.com/den0056/b/DEN0056B_System_Control_and_Managemen=
t_Interface_v2_0.pdf

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

