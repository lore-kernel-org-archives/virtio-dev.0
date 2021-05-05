Return-Path: virtio-comment-return-1846-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210401152013.17980-1-harald.mommer@opensynergy.com>
 <YIaQUdRjndmrBK2l@stefanha-x1.localdomain>
From: Harald Mommer <hmo@opensynergy.com>
Message-ID: <df232473-f2b9-9ef4-42d8-f172ecfddc96@opensynergy.com>
Date: Wed, 5 May 2021 12:33:19 +0200
In-Reply-To: <YIaQUdRjndmrBK2l@stefanha-x1.localdomain>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH 1/1] [RFC] virtio-can: Add the device
 specification.
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

a lot of helpful comments, thank you for this work. Took some time to 
answer and about some things I will still have to think.

Am 26.04.21 um 12:05 schrieb Stefan Hajnoczi:
> On Thu, Apr 01, 2021 at 05:20:13PM +0200, Harald Mommer wrote:
>> virtio-can is a virtual CAN device. It provides a way to give access to
>> a CAN controller from a driver guest. The device is aimed to be used by
>> driver guests running a HLOS as well as by driver guests running a
>> typical RTOS as used in controller environments.
> Hi,
> I'm not familiar with CAN but have tried to give general feedback since
> no one else has replied yet.
>
> The commit description isn't completely clear about what this new VIRTIO
> device is. I guess it's a virtual CAN controller rather than a CAN
> device. The "give access to a CAN controller" wording suggests that it's
> for passthrough, but the CAN controller could probably be purely
> software too. I'm sure this will become clearer from the diff below, but
> wanted to mention it since others may also find it ambiguous.
What I'm currently developing is a passthrough device. The device 
application will use SocketCAN to access an underlying Linux CAN driver 
and the Linux virtio CAN driver will be a network driver which can be 
accessed by SocketCAN. The underlying Linux driver on the device side 
may either drive a physical CAN controller or may be a pure software 
solution like vcan not accessing any real CAN hardware. My collegues 
from the AUTOSAR team will most probably put the their implementation 
some day on top of a physical AUTOSAR CAN driver providing also a 
AUTOSAR CAN driver interface on the virtio driver guest side. Other 
implementations not doing a passthrough device are possible however 
implementing this as a pass-through device is the easiest way of 
implementing this.
>> ---
>>   content.tex      |   1 +
>>   introduction.tex |   3 +
>>   virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 249 insertions(+)
>>   create mode 100644 virtio-can.tex
>>
>> diff --git a/content.tex b/content.tex
>> index e536fd4..c1604db 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>>   \input{virtio-mem.tex}
>>   \input{virtio-i2c.tex}
>>   \input{virtio-scmi.tex}
>> +\input{virtio-can.tex}
>>   
>>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   
>> diff --git a/introduction.tex b/introduction.tex
>> index 7204b24..84ea5c0 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative References}
>>   	\phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
>>   	Arm System Control and Management Interface, DEN0056,
>>   	\newline\url{https://developer.arm.com/docs/den0056/c}, version C and any future revisions\\
>> +	\phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
>> +	Specification of CAN Driver -- AUTOSAR CP R20-11,
>> +	\newline\url{https://www.autosar.org/fileadmin/user_upload/standards/classic/20-11/AUTOSAR_SWS_CANDriver.pdf}\\
> "The commercial exploitation of the material contained in this work
> requires a license to such intellectual property rights."?
>
> CAN is an ISO standard. What is the relationship to AUTOSAR and why not
> reference the ISO standard? The CAN Wikipedia page
> (https://en.wikipedia.org/wiki/CAN_bus) only mentions ISO, not AUTOSAR.

The AUTOSAR CAN driver specification describes an API for an AUTOSAR CAN 
driver. One of the goals was that it should be possible to write a 
virtio CAN driver providing a usable subset of the AUTOSAR CAN driver 
API. There are collegues here working on embeeded controllers using 
AUTOSAR and virtio CAN should serve their purposes. On the other hand, 
virtio CAN must also serve the needs for the non-AUTOSAR audience. In 
the end the specification must fulfill the needs of the AUTOSAR audience 
and the non-AUTOSAR audience dancing on two weddings at the same time.

Not referenced the ISO standard because I did not really look into this 
to develop the specification. Referenced what I really looked in to 
specify something which MAY be used to develop a virtio CAN driver with 
an AUTOSAR CAN driver interface on top.

If the special licensing of the AUTOSAR specification is a problem 
(guess it is) I think the solution is to ensure that a non AUTOSAR 
implementation can be done without having to look into the AUTOSAR 
specification itself. If this is not sufficient I need to know to 
address the problem properly.

> Also, does the AUTOSAR reference mean that this is a specific flavor of
> CAN that may not be compatible with other CAN variants?

This reference to the AUTOSAR spec does not mean that virtio CAN is 
incompatible with ISO. It just means that I looked heavily into the 
AUTOSAR CAN specifiation.

But it may be that my brain is polluted with too much AUTOSAR the draft 
specification does not fulfill all needs of audience not interested in 
AUTOSAR but for example in Linux SocketCAN. During last week working at 
some driver/device prototype using SocketCAN I realized that there is no 
support for remote transmission request frames in the virtio CAN draft 
specification but in SocketCAN. AUTOSAR does not support this, the 
feature was removed totally from CAN FD. Could be that the missing 
support is a shortcoming. Could be that the feature was removed from CAN 
FD because nobody in the world is using it and it's obsolete.

So some detail(s) which may be considered mandatory - also some I'm not 
even aware of - may be missing. I hope to get some feedback about this 
on the list.

>>   \end{longtable}
>>   
>> diff --git a/virtio-can.tex b/virtio-can.tex
>> new file mode 100644
>> index 0000000..c343759
>> --- /dev/null
>> +++ b/virtio-can.tex
>> @@ -0,0 +1,245 @@
>> +\section{CAN Device}\label{sec:Device Types / CAN Device}
>> +
>> +virtio-can is a virtio based CAN (Controller Area Network) device. It is
> s/device/controller/ ?
yes
>> +used to give a virtual machine access to a CAN bus. The CAN bus may
>> +either be a physical CAN bus or a virtual CAN bus between virtual
>> +machines or a combination of both.
>> +
>> +This section relies on definitions made by the AUTOSAR
>> +\hyperref[intro:CAN_Driver]{CAN Driver} specification.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
>> +
>> +36
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] Txq
>> +\item[1] Rxq
>> +\item[2] Controlq
>> +\item[3] Indicationq
>> +\end{description}
>> +
>> +The \field{Txq} is used to send CAN packets to the CAN bus.
>> +
>> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
>> +
>> +The \field{Controlq} is used to control the state of the CAN controller.
>> +
>> +The \field{Indicationq} is used to receive unsolicited indications of
>> +CAN controller state changes.
>> +
>> +\subsection{Feature Bits}\label{sec:Device Types / CAN Device / Feature Bits}
>> +
>> +The virtio-can device always supports classic CAN frames with a maximum
>> +payload size of 8 bytes.
>> +
>> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
>> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
>> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
>> +specification.
> Please state this in a devicenormative section:
>
>    \devicenormative{\subsection}{...}
>    The device MUST support CAN~2.0B Extended CAN IDs.
>
> The general spec text is informative and then specific statements about
> what MUST, MUST NOT, SHOULD, etc are made in drivernormative and
> devicenormative sections. You can find examples of this in the specs for
> other devices.
Means the document structure has to be reworked generally to have the 
requirements (MUST, SHOULD) in appropriate sections.
>> +
>> +\begin{description}
>> +
>> +\item[VIRTIO_CAN_F_CAN_FD (0)]
>> +
>> +In addition to classic CAN frames the device supports CAN FD frames with
>> +a maximum payload size of 64 bytes.
> Is there a link for CAN FD? I found "CAN with Flexible Data-Rate" but
> it's just a Wayback Machine link and not the official location:
> https://web.archive.org/web/20151211125301/http://www.bosch-semiconductors.de/media/ubk_semiconductors/pdf_1/canliteratur/can_fd_spec.pdf

Have this specification also in my folder, got it also exactly from 
there. No better link. While most things in this document are still 
valid and it's nice to have some (here probably irrelevant details like 
CRC calculation) in this Bosch spec are outdated now. CAN FD is now 
officially described in ISO 11898-1:2015, a link would go to the ISO 
shop or similar.

Adding the ISO to the reference list would eliminate some questions 
raised here, I should do this.

>> +
>> +\end{description}
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout}
>> +
>> +All fields of this configuration are always available and read-only for
>> +the driver.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_config {
>> +        le16 lo_prio_count;
>> +        le16 hi_prio_count;
>> +};
>> +\end{lstlisting}
>> +
>> +To operate the Virtio CAN device it may be necessary to know some basic
>> +properties of the underlying physical CAN controller hardware and its
>> +configuration.
>> +
>> +Physical CAN controllers may support transmission by putting messages
> "may", "should", "can", "must", etc are not used in the informative
> sections of the spec. Those kinds of statements go in the
> drivernormative and devicenormative sections.
Will have to restructure the document structure.
>> +into FIFOs first and / or by using transmit buffers directly. The user
>> +of the Virtio CAN driver may need to know
> This can be rewritten without the concept of a "physical CAN
> controller". Simply describe lo_prio_count/hi_prio_count as properties
> of the virtio-can device itself and then the physical CAN controller
> concept isn't needed. This is makes the spec more general since emulated
> CAN controllers might have their own constraints even though there is no
> physical CAN controller.

A classic CAN bus has a bandwith of typically 500 kbps. Which is not 
this much and is therefore to be considered as bottleneck. Virtual stuff 
come typically with bandwithes in the magnitude of the internal RAM 
(Gigabytes/s) or at least PCI (Gigabits/s). Prioritization makes no 
sense any more for those non-physical CAN devices on which the transport 
medium is magnitutes faster as a physical CAN bus. Have had this 
disussions internally any my opinion is that for non-physical devices 
prioritization makes no sense at all. So no, I prefer not to reformulate 
in this way.

>> +
>> +\begin{itemize}
>> +\item Number of TX FIFO places for non time critical CAN messages
>> +\item Number of TX buffers for high priority CAN messages
> Inconsistencies:
> - FIFO places == buffers?
> - non time critical == low priority?
>
> Please use terminology consistently. Don't introduce multiple terms for
> the same thing.
The different terminology is intentional as those are different things. 
There are wait queue places in the FIFO not participating in bus 
arbitration and transmission buffers participating in bus arbitration.
>> +\end{itemize}
>> +
>> +to schedule an optimal transmission of CAN messages. Non time critical
>> +messages may be sent via a FIFO where they may suffer "Inner Priority
>> +Inversion" (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 2.1). High
>> +priority messages are preferably sent directly to a transmit buffer
>> +where they immediately participate in CAN bus arbitration.
> Please mention lo_prio_count and hi_prio_count so their meaning is
> unambiguous and they can easily be searched by name in the document. The
> \begin{itemize} above should explicitly mention lo_prio_count and
> hi_prio_count.
If I understand this correctly it's a formatting issue which has to be 
addressed.
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / CAN Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +
>> +\item Read the feature bits and negotiate with the device.
>> +
>> +\item Fill the virtqueue \field{Rxq} with empty buffers to be ready for
>> +the reception of CAN messages.
> How large do the buffers need to be? A drivernormative "MUST" statement
> is probably needed for this.
I consider this as an implementation decision. Doing an implementation l 
would provide enough buffers so that no CAN message received on the bus 
is lost. The actual choice depends on the maximum received message rate, 
time to service a received CAN message and in case of a polling driver 
also on the polling cycle.
>> +
>> +\item Fill the virtqueue \field{Indicationq} with empty buffers so that
>> +the CAN device is able to provide status change indications to the
>> +virtio CAN driver.
> Do these buffers have a specific structure/size? I see struct
> virtio_can_busoff_ind below but maybe a more general type is needed. If
> the indication message types depend on the virtio-can device then it
> could expose a configuration field so the driver knows how large
> Indicationq buffers need to be.

There is currently only one message type defined for this channel, this 
is VIRTIO_CAN_BUSOFF_IND. The message definition (struct 
virtio_can_busoff_ind) has a length of 2 bytes bearing only le16 
msg_type. So a buffer with this a size of 2 bytes has to be provided in 
order to bear the structure / message. A future version of the 
specification may of course define an additional message type on the 
channel with a bigger structure / message definition but this would then 
require a feature flag to allow the device to send this indication. (Do 
I have understood the problem? There seems to be none.)

>> +
>> +\item Read the CAN controller properties using the \field{Controlq}.
>> +
>> +\item Start the CAN controller using the \field{Controlq}.
>> +
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
>> +
>> +A device operation has an outcome which is described by one of the
>> +following values:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CAN_RESULT_OK     0u
>> +#define VIRTIO_CAN_RESULT_NOT_OK 1u
>> +\end{lstlisting}
>> +
>> +The type of a CAN message identifier is identified by the most
>> +significant 2 bits of the internally used 32 bit value. This matches the
>> +definition for Can_IdType in
>> +\hyperref[intro:CAN_Driver]{CAN Driver} chapter 8.2.3.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CAN_ID_TYPE_STANDARD    0x00000000U
>> +#define VIRTIO_CAN_ID_TYPE_STANDARD_FD 0x40000000U
>> +#define VIRTIO_CAN_ID_TYPE_EXTENDED    0x80000000U
>> +#define VIRTIO_CAN_ID_TYPE_EXTENDED_FD 0xC0000000U
>> +\end{lstlisting}
>> +
>> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
>> +
>> +The general format of a request in the \field{Controlq} is
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_control_out {
>> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
>> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
>> +        le16 msg_type;
>> +};
>> +\end{lstlisting}
>> +
>> +To participate in bus communication the CAN controller must be started
>> +by sending a VIRTIO_CAN_SET_CTRL_MODE_START control message,
>> +to stop participating in bus communication it must be stopped by sending
>> +a VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
>> +confirmed by the result of the operation.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_set_ctrl_mode_in {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +If the transition succeeded the result shall be VIRTIO_CAN_RESULT_OK
>> +otherwise it shall be VIRTIO_CAN_RESULT_NOT_OK. The request shall be put
>> +into the used queue when the CAN controller finalized the transition to
>> +the requested controller mode.
> "shall" is not for drivernormative/devicenormative sections. Simply
> using "is" instead of "shall be" works here.
>
> "the used queue" is specific to Split Virtqueues. Packed Virtqueues are
> organized differently. I suggest rewording this sentence:
>
>    The device marks the request used when the CAN controller has
>    finalized the transition to the requested controller mode.
>
> ("2.7.9 Multi-buffer requests" uses the "mark used" language. Another
> option is "the device uses the request when ...".)
Will have to re-formulate so that the sentence becomes valid for the 
newer packet virtqueues also.
>> +
>> +A transition to STOPPED state cancels all CAN messages pending for
>> +transmission. A state transition to STOPPED state shall trigger to put
>> +all CAN messages pending for transmission into the used queue with
>> +result VIRTIO_CAN_RESULT_NOT_OK.
> The exact behavior is not clear to me. There are several cases:
>
> 1. A tx message that was being transmitted when the
>     VIRTIO_CAN_SET_CTRL_MODE_STOP control message was submitted.
> 2. A tx message that was on the Txq but not yet transmitted when the
>     VIRTIO_CAN_SET_CTRL_MODE_STOP control message was submitted.
> 3. A tx message that was added to the Txq after the
>     VIRTIO_CAN_SET_CTRL_MODE_STOP control message was submitted.
>
> I guess they behave as follows:
>
> 1. The message might finish transmitting successfully or the message
>     might complete with VIRTIO_CAN_RESULT_NOT_OK.
> 2. These messages complete with VIRTIO_CAN_RESULT_NOT_OK.
> 3. These messages might complete with VIRTIO_CAN_RESULT_NOT_OK or they
>     might transmit successfully.
>
> Another thought: the text is clearer when it explicitly mentions the
> entity (driver or device) and the virtqueue (Txq or Controlq) involved:
>
>    When the device transitions to the STOPPED state all CAN messages on
>    the Txq complete with VIRTIO_CAN_RESULT_NOT_OK.
>
> That makes it clear that the device needs to do this, not the driver. It
> also makes it clear that we're describing effects on the Txq, not the
> Controlq where the VIRTIO_CAN_SET_CTRL_MODE_STOP was submitted.

I tend to use passive in specifying things which is considered as not 
optimal. Old mistake, got caught again.

1. 2. meets also my understanding. 3. also. But if the word "submitted" 
is replaced by "received" ruling out the race the result is expected to 
be VIRTIO_CAN_RESULT_NOT_OK.

>> +
>> +Initially the CAN controller is in STOPPED state.
> s/in STOPPED state/in the STOPPED state/
>
>> +
>> +\subsubsection{CAN Message Transmission}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Transmission}
>> +
>> +Messages may be transmitted by placing outgoing CAN messages in the
> s/may be/are/
>
> (To avoid using shall/may/should/etc language outside
> drivernormative/devicenormative sections.)
>
>> +virtqueue \field{Txq}.
> Grammar tweak:
> s/virtqueue \field{Txq}/\field{Txq} virtqueue/
>
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_tx_out {
>> +#define VIRTIO_CAN_TX 0x0001u
>> +        le16 msg_type;
>> +        le16 priority;
>> +        le32 can_id;
>> +        u8 sdu[];
>> +};
>> +
>> +struct virtio_can_tx_in {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +Priority is 0 for low priority and 1 for high priority CAN messages.
> Please use /field{priority} to make it clear which field is being
> described.
>
>> +
>> +The actual length of the SDU can be calculated from the length of the device
>> +read-only descriptor.
>    The length of \field{sdu} is implicit in the length of the device
>    read-only descriptors.
>
> I used "descriptors" here because "2.6.4 Message Framing" says that
> drivers can choose arbitrary descriptor lengths. The device cannot
> assume struct virtio_can_tx_out will be in a single descriptor.
Will replace the wrong sentence.
>> +
>> +To avoid internal priority inversion in the \field{Txq} the user of the
>> +driver may do a book keeping of in flight transmission requests and
>> +defer sending of TX messages until the chosen transmission resource
>> +becomes available.
>> +
>> +If priority, can_id or SDU length are out of range or the CAN controller
> \field is missing for priority and can_id.
>
>> +is in an invalid state result shall be set to VIRTIO_CAN_RESULT_NOT_OK
>> +and the message shall not be scheduled for transmission. Sending a CAN
>> +message with a priority with 0 transmission places configured shall
>> +be considered as priority being out of range.
>> +
>> +If the parameters are valid the message is scheduled for transmission
>> +and result is set to VIRTIO_CAN_OK. The transmission request should be
> \field{result}
>
>> +put into the used queue after the physical CAN controller acknowledged
>> +the transmission on the CAN bus (may have to be put under a feature flag
>> +as there may be non AUTOSAR CAN driver backends which don't provide a
>> +trigger to do this correctly).
> There is a TODO item here.

Having an AUTOSAR CAN driver backend there is a callback indication when 
the message was physically transmitted on the bus. No problem there. For 
SocketCAN it looks like there is a feature to receive the own sent 
message tagged as sent by the own CAN node. With this it should be 
possible to implement this timing requirement as intended. But I'm still 
investigating whether this feature is provided always and this may not 
be the case. It's a detail which is more complicated as I thought. So 
this TODO is something which cannot be closed today finally, still 
investigating this detail.

Will have to plan now internally when to update the draft spec and to 
re-send an updated version. I'm currently with both hands in some 
prototype implementation serving and using Linux SocketCAN. 
Prioritiziung this work may be benefitial for the next draft spec. as I 
may still learn about some details and pitfalls doing an actual 
implementation.



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

