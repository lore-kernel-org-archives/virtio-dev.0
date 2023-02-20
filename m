Return-Path: <virtio-dev-return-11128-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <9e8e79b0-dbd4-710d-187f-de33f9dda5d8@linux.alibaba.com>
Date: Mon, 20 Feb 2023 22:25:49 +0800
MIME-Version: 1.0
References: <20230219144507.22932-1-hengqi@linux.alibaba.com>
 <20230219094802-mutt-send-email-mst@kernel.org>
 <20230220074413.GA86514@h68b04307.sqa.eu95>
 <20230220080627-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230220080627-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v4] virtio-net: support the virtqueue coalescing
 moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2023/2/20 =E4=B8=8B=E5=8D=889:14, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Mon, Feb 20, 2023 at 03:44:13PM +0800, Heng Qi wrote:
>> On Sun, Feb 19, 2023 at 10:06:51AM -0500, Michael S. Tsirkin wrote:
>>> On Sun, Feb 19, 2023 at 10:45:07PM +0800, Heng Qi wrote:
>>>> Currently coalescing parameters are grouped for all transmit and recei=
ve
>>>> virtqueues. This patch supports setting or getting the parameters for =
a
>>>> specified virtqueue, and a typical application of this function is net=
dim[1].
>>>>
>>>> When the traffic between virtqueues is unbalanced, for example, one vi=
rtqueue
>>>> is busy and another virtqueue is idle, then it will be very useful to
>>>> control coalescing parameters at the virtqueue granularity.
>>>>
>>>> [1] https://docs.kernel.org/networking/net_dim.html
>>>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> ---
>>>> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-=
open.org/archives/virtio-dev/202302/msg00431.html .
>>>>
>>>> v3->v4:
>>>>      1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq st=
ructure. @Alvaro Karsz
>>>>      2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pan=
dit, @Alvaro Karsz
>>>>      3. Avoid too many examples by giving a comprehensive example. @Mi=
chael S. Tsirkin
>>>>      4. Fix typos and streamline clarifications. @Michael S. Tsirkin, =
@Parav Pandit, @Alvaro Karsz
>>>>
>>>> v2->v3:
>>>>      1. Add the netdim link. @Parav Pandit
>>>>      2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NO=
TF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>>>>      3. _VQ_GET is explained more. @Michael S. Tsirkin
>>>>      4. Add more examples to avoid misunderstandings. @Michael S. Tsir=
kin
>>>>      5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @=
Alvaro Karsz
>>>>      6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsir=
kin
>>>>      7. Fix some typos. @Michael S. Tsirkin
>>>>
>>>> v1->v2:
>>>>      1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF=
_COAL. @Michael S. Tsirkin
>>>>      2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>>>>      3. Unify tx and rx control structres into one structure virtio_ne=
t_ctrl_coal_vq. @Michael S. Tsirkin
>>>>      4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Micha=
el S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>>>      5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOT=
F_COAL can be used. @Alvaro Karsz
>>>>      6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pa=
ndit, @Alvaro Karsz
>>>>
>>>>   device-types/net/description.tex | 64 ++++++++++++++++++++++++++++++=
--
>>>>   1 file changed, 60 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/device-types/net/description.tex b/device-types/net/descr=
iption.tex
>>>> index e71e33b..fa8bd26 100644
>>>> --- a/device-types/net/description.tex
>>>> +++ b/device-types/net/description.tex
>>>> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / N=
etwork Device / Feature bits
>>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contro=
l
>>>>       channel.
>>>>  =20
>>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notifi=
cation coalescing.
>>>> +
>>>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coal=
escing.
>>>>  =20
>>>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets=
.
>>>> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec=
:Device Types / Network Device
>>>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTI=
O_NET_F_HOST_TSO6.
>>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>   \end{description}
>>>>  =20
>>>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Type=
s / Network Device / Feature bits / Legacy Interface: Feature bits}
>>>> @@ -1508,6 +1511,12 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
>>>>   If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>>>>   send control commands for dynamically changing the coalescing parame=
ters.
>>>>  =20
>>>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>>>> +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to se=
t the coalescing
>>>> +   parameters of an enabled transmit/receive virtqueue.
>>>> +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a =
device, and the device
>>>> +   returns the coalescing parameters of an enabled transmit/receive v=
irtqueue.
>>>> +
>>>>   \begin{note}
>>>>   The behavior of the device in response to these commands is best-eff=
ort:
>>>>   the device may generate notifications more or less frequently than s=
pecified.
>>>> @@ -1519,25 +1528,55 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>       le32 max_usecs;
>>>>   };
>>>>  =20
>>>> +struct virtio_net_ctrl_coal_vq {
>>>> +    le16 vqn;
>>>> +    le16 reserved;
>>>> +    struct virtio_net_ctrl_coal coal;
>>>> +};
>>>> +
>>> 2 structures now, what are they doing? which command uses which?
>>> reader is supposed to guess and that's not good.
>>>
>>> Also, with VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET some fields are
>>> output others are input. This is unusual for commands
>>> and needs to be documented very clearly.
>> Yes, this should be made clear. How do you think of the following descri=
ptions:
>>
>> "
>> The VIRTIO_NET_CTRL_NOTF_COAL_{TX, RX}_SET commands use the
> I think it's better to just say  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and
>   VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> We don't document the {} syntax anywhere.

Ok, I'll modify this.

>
>> virtio_net_ctrl_coal structure to set \field{max_usecs} and
>> \field{max_packets} for all transmit/receive virtqueues.
>>
>> The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the
>> virtio_net_ctrl_coal_vq structure to set \field{max_usecs}
>> and \field{max_packets} for the supplied virtqueue number \field{vqn}.
>>
>> The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of
>> \field{max_usecs} and \field{max_packets} of the specified
>> virtqueue from the device by only setting \field{vqn} in virtio_net_ctrl=
_coal_vq.
>> "
>
> Not enough imho. Document which fields are write-only for driver and
> which are read-only for driver. and includes reserved field not just
> vqn.

OK I rephrase it into following sentences (Combined with the following,=20
\field{vqn}'s and\field{reserved}'s explanations may be a bit redundant,=20
but I will merge them in the next version ) :

"
\field{max_usecs} and \field{max_packets} are collectively known as=20
coalescing parameters.
\field{vqn} and \field{reserved} are only used by=20
VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET=20
commands.
\field{vqn} points to an enabled transmit/receive virtqueue, and its=20
value satisfies $ 0 \leq vqn < max_virtqueue_pairs \ast 2 $.
 =C2=A0\field{reserved} is a reserved field containing 0, which is ignored =
by=20
a device and write-only for a driver.

VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_TX_SET=20
commands use the virtio_net_ctrl_coal structure to set \field{max_usecs}=20
and \field{max_packets} for all transmit/receive virtqueues, while=20
coalescing parameters are write-only for a driver.

The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the=20
virtio_net_ctrl_coal_vq structure to set \field{max_usecs} and=20
\field{max_packets} for the supplied virtqueue number \field{vqn}, while=20
coalescing parameters and \field{vqn} are write-only for a driver.

The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of=20
\field{max_usecs} and \field{max_packets} of the specified virtqueue=20
from a device by only setting \field{vqn} in virtio_net_ctrl_coal_vq. At=20
this time, for a driver, coalescing parameters are read-only and=20
\field{vqn} is write-only.
"
Do you think this is a good description?

>>>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>>>   \end{lstlisting}
>>>>  =20
>>>>   Coalescing parameters:
>>>>   \begin{itemize}
>>>> +\item \field{vqn}: The virtqueue number of an enabled transmit or rec=
eive virtqueue.
>>>>   \item \field{max_usecs} for RX: Maximum number of microseconds to de=
lay a RX notification.
>>>>   \item \field{max_usecs} for TX: Maximum number of microseconds to de=
lay a TX notification.
>>>>   \item \field{max_packets} for RX: Maximum number of packets to recei=
ve before a RX notification.
>>>>   \item \field{max_packets} for TX: Maximum number of packets to send =
before a TX notification.
>>>>   \end{itemize}
>>>>  =20
>>>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>> +\field{vqn} points to an enabled transmit/receive virtqueue, and its =
value satisfies $ 0 \leq vqn < max_virtqueue_pairs \ast 2 $.
>>>> +
>>>> +\field{reserved} is reserved and it is ignored by the device.
>>>> +
>>>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>>>   \begin{enumerate}
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and=
 \field{max_packets} parameters for all transmit virtqueues.
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and=
 \field{max_packets} parameters for all receive virtqueues.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and=
 \field{max_packets} parameters for an enabled transmit/receive
>>>> +                                        virtqueue whose number is \fi=
eld{vqn}.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field=
{max_usecs} and \field{max_packets} parameters for an enabled
>>>> +                                        transmit/receive virtqueue wh=
ose number is \field{vqn}.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect as the V=
IRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each virtqueue of tran=
smitq1\ldots transmitqN.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect as the V=
IRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each virtqueue of rece=
iveq1\ldots receiveqN.
>>>>   \end{enumerate}
>>>>  =20
>>>> +If coalescing parameters are being set, the device applies the last c=
oalescing parameters received for a
>>>> +virtqueue, regardless of the command used to set the parameters. For =
example with 2 pairs of virtqueues:
>>>> +# Command sequece
>>>> +Each of the following commands sets \field{max_usecs} and \field{max_=
packets} parameters for virtqueues.
>>>> +\begin{itemize}
>>>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets parameters for =
virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain their prev=
ious parameter values.
>>>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D=
 0 sets parameters for virtqueue0, and virtqueue2 retains the values from c=
ommand1.
>>>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn}=3D =
0, the device returns paramters of virtqueue0 set by command2.
>>>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D=
 1 sets parameters for virtqueue1, and virtqueue3 retains its previous valu=
es.
>>>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets parameters for =
virtqueue1 and virtqueue3, and overrides the values set by command4.
>>>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn}=3D =
1, the device returns paramters of virtqueue1 set by command5.
>>>> +\end{itemize}
>>>> +
>>>>   \subparagraph{Operation}\label{sec:Device Types / Network Device / D=
evice Operation / Control Virtqueue / Notifications Coalescing / Operation}
>>>>  =20
>>>>   The device sends a used buffer notification once the notification co=
nditions are met and if the notifications are not suppressed as explained i=
n \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer N=
otification Suppression}.
>>>> @@ -1585,14 +1624,31 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>  =20
>>>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Notifications =
Coalescing}
>>>>  =20
>>>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the dr=
iver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>>>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_CO=
AL feature
>>>> +has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NO=
TF_COAL commands.
>>> Triple negative? I think you mean "has been negotiated".
>> Yes. Thanks for pointing it out.
>>
>>> Generally we should consider rewriting these in a positive way
>>> but that's a subject for another patch.
>> Ok, I see.
>>
>>>> +
>>>> +A driver MUST ignore the values of coalescing paramters received from=
 VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET,
>>>> +if the device returns with VIRTIO_NET_ERR.
>>> device does not return. It responds to the command.
>> Ok.
>>
>>>>  =20
>>>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Notifications =
Coalescing}
>>>>  =20
>>>>   A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands wi=
th VIRTIO_NET_ERR if it was not able to change the parameters.
>>>> +Note: VIRTIO_NET_CTRL_NOTF_COAL_VQ_{SET, GET} are exception to it, wh=
ich must return VIRTIO_NET_ERR if the device was unable to change the param=
eters.
>>> I don't get it. what is exception to what and what's the difference,
>>> what does "which" refer to what return VIRTIO_NET_ERR where.
>>>
>> Sorry for not describing clearly, please see the explanation below:
>> When a device receives VIRTIO_NET_CTRL_NOTF_COAL_VQ_{SET, GET} and VIRTI=
O_NET_CTRL_NOTF_COAL_{TX, RX}_SET respectively,
>> and the device was not able to change the parameters, then it behaves di=
fferently for VIRTIO_NET_CTRL_NOTF_COAL_VQ_{SET, GET} and VIRTIO_NET_CTRL_N=
OTF_COAL_{TX, RX}_SET, ie SHOULD and MUST.
>> For example:
>> 1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets parameters for all transmit/rec=
eive virtqueues, but if only receiveq1 fails to be set, and receiveq2\ldots=
 receiveqN are set successfully,
>>     then the device *SHOULD* respond VIRTIO_NET_ERR for VIRTIO_NET_CTRL_=
NOTF_COAL_RX_SET.
>> 2. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET sets parameters for the virtqueue wh=
ose number is \field{vqn}, if the device fails to set, the device *MUST* re=
spond VIRTIO_NET_ERR for VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET.
> So document the two types separately. Change VIRTIO_NET_CTRL_NOTF_COAL
> to VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> and add a new sentence for VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET.

Ok.

>
> And VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET does not change anything so I have
> no idea why mention it at all.

Ah, you mean the scope of MUST is included in SHOULD?
If you think it's better to remove the *Note* above, I'm fine.

>
>
>
>>>>  =20
>>>>   A device SHOULD NOT send used buffer notifications to the driver if =
the notifications are suppressed, even if the notification conditions are m=
et.
>>>>  =20
>>>> +If a virtqueue is disabled, the device MUST clear its parameters conf=
iguration, and:
>>> parameters here meanong coalescing parameters? It won't be clear to
>> Yes, I'll write clearly.
>>
>>> readers who see the full spec not the patch.
>>>
>>>> +1. if the device has received a global parameter values sent by VIRTI=
O_NET_CTRL_NOTF_{RX, TX}_SET:
>>> "a" does not go with the plural "values".
>> Ok.
>>
>>>> +after the virtqueue is enabled, its parameters SHOULD be set to the g=
lobal values.
>>>
>>> this is the first you mention global.
>> I mentioned "global" in the first sentence, but that might not seem very=
 clear.
>>
>>>> +2. if the device hasn't received the VIRTIO_NET_CTRL_NOTF_{RX, TX}_SE=
T commands:
>>>> +regardless of whether the device has received a VIRTIO_NET_CTRL_NOTF_=
COAL_VQ_SET command, after the
>>>> +virtqueue is enabled, its parameters SHOULD be set to 0.
>>> Sentence too long at this point I can't say what happens after what.
>>>
>>>
>>> I feel this enumeration of cases is confusing. Would be better to find
>>> the logic behind all this and document.
>>>
>>> For example, we could explain that
>>>
>>>
>>> VIRTIO_NET_CTRL_NOTF_{RX, TX}_SET set
>>> global values for coalescing parameters for RX and TX respectively and
>>> apply these global values to all VQs of the given type.
>>> Global values after device reset are 0.
>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET sets the coalescing parameters for
>>> a given enabled VQ without changing the global values.
>>> Fails on a disabled VQ.  Disabling and
>>> re-enabling a VQ reverts its coalescing parameters back to global value=
s.
>>
>> Thanks for your example, I tried to regularize it, do you think it works=
?
>>
>> "
>> The VIRTIO_NET_CTRL_NOTF_{RX, TX}_SET commands set coalescing parameters=
 for all transmit/receive
>> virtqueues respectively and values of these coalescing parameters are re=
corded as *global values* by the device.
>> The device MUST set the global values of coalescing parameters to 0 afte=
r being reset.
>> The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command sets the coalescing paramet=
ers for a given enabled virtqueue without changing the global values.
>> After disabling and re-enabling a virtqueue, the deivce MUST revert coal=
escing parameters of the virtqueue back to global values.
> ok more or less. is this in normative section? If not avoid MUST.

Yes. It's in normative section. Thanks for your comments!

>
> And maybe add text in a normative section too. a bit of repetition there
> is ok.
>
>
>> "
>>
>>>
>>>
>>>> +
>>>> +When a device receives a virtqueue command to set or return coalescin=
g parameters for the supplied \field{vqn},
>>>> +if the virtqueue is not enabled, the device MUST respond to the comma=
nd with VIRTIO_NET_ERR.
>>>> +
>>>> +A device MAY set the coalescing parameter to a value close to a power=
 of 2 value.
>>>> +
>>>>   Upon reset, a device MUST initialize all coalescing parameters to 0.
>>>>  =20
>>>>   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Dev=
ice
>>>> --=20
>>>> 2.19.1.6.gb485710b

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

