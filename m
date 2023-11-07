Return-Path: <virtio-dev-return-14044-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED962C4332F
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Nov 2023 17:10:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 606642AD54
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Nov 2023 17:10:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5309A986C8A
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Nov 2023 17:10:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 44EC6986C23; Tue,  7 Nov 2023 17:10:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DDB0986C22;
	Tue,  7 Nov 2023 17:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <c1622239-80a0-4332-8650-367e1bfc1ea3@quicinc.com>
Date: Wed, 8 Nov 2023 01:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>
References: <20231024125346.23546-1-quic_haixcui@quicinc.com>
 <56fbe6cc-d7a5-438f-1dd2-939f4197a970@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <56fbe6cc-d7a5-438f-1dd2-939f4197a970@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kmjttBXWlY_l97fj0d0VK1jBpztJmzJJ
X-Proofpoint-ORIG-GUID: kmjttBXWlY_l97fj0d0VK1jBpztJmzJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_08,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070142
Subject: [virtio-dev] Re: [PATCH v4] virtio-spi: add the device specification

Hi Harald,
     Please refer to my following replies to your comments. Thank you 
very much.

On 10/27/2023 9:02 PM, Harald Mommer wrote:
> Hello Haixu,
> 
> this delay stuff causes some headache.
> 
> On 24.10.23 14:53, Haixu Cui wrote:
>> virtio-spi is a virtual SPI master and it allows a guest to operate and
>> use the physical SPI master controlled by the host.
>>
>> This patch adds the specification for virtio-spi.
>>
>> Signed-off-by: Haixu Cui<quic_haixcui@quicinc.com>
>> ---
>>   device-types/spi/description.tex        | 206 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 +
>>   device-types/spi/driver-conformance.tex |   7 +
>>   3 files changed, 220 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
>>
>> diff --git a/device-types/spi/description.tex 
>> b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..5dbceaf
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,206 @@
>> +\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
>> +
>> +virtio-spi is a virtual SPI (Serial Peripheral Interface) master and 
>> it allows
>> +a guest to operate and use the physical SPI master controlled by the 
>> host.
>> +
>> +virtio-spi has a single virtqueue. SPI transfer requests are placed into
>> +the virtqueue, and serviced by the physical SPI master.
>> +
>> +In a typical host and guest architecture with virtio-spi, Virtio SPI 
>> driver is
>> +the front-end existing in the guest kernel, and Virtio SPI device 
>> acts as the
>> +back-end in the host platform.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / SPI Master Device / 
>> Device ID}
>> +45
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / SPI Master Device / 
>> Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] requestq
>> +\end{description}
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / SPI Master Device 
>> / Feature bits}
>> +
>> +None
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / SPI 
>> Master Device / Device configuration layout}
>> +
>> +All fields of this configuration are always available and read-only 
>> for Virtio SPI driver.
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_config {
>> +    le16 bus_num;
>> +    le16 chip_select_max_number;
>> +    le8 cs_timing_setting_enable;
> The naming "cs_timing_setting_enable" may be sub-optimal as also timings 
> which have nothing to do with CS (chip select) are affected. See below 
> where it's discussed in more detail.

For delay parameters(including cs delay setting), see below, a big topic.
>> +    le8 reserved[3];
> 
> There is no "le8". This is "u8".
yes! u8, i made a mistake

> 
> BTW, I currently in my Linux driver code announce support for 8 and 16 
> bit SPI word length out of the blue, 125000000 bps transfer speed out of 
> the blue not knowing what my back end device really supports. In struct 
> spi_master the mode member is set to all kinds of bits hoping for the 
> best without really knowing whether the virtio SPI device supports all 
> of this.
> 
> For a first specification version this may be acceptable that there is 
> announced something based on nothing but I already see that the 
> information provided in the config space will not be the last word for 
> all times looking at my code.
> 
I also consider more fields in config space, or introduce another 
virtqueue to exchange some information between front and back, this will 
let front-end knows more about the virtio SPI device. And this needs 
more investigation.

>> +};
>> +\end{lstlisting}
>> +
>> +The \field{bus_num} indicates the physical SPI master assigned to guest.
>> +
>> +The \field{chip_select_max_number} is the maximum number of 
>> chipselect the physical SPI master supports.
>> +
>> +The \field{cs_timing_setting_enable} indicates if the physical SPI 
>> master supporting cs timing setting:
>> +    0: physical SPI master doesn't support cs timing setting;
>> +    1: physical SPI master supports cs timing setting.
>> +
>> +The \field{reserved} is for alignment purpose, also for future 
>> extension.
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / SPI 
>> Master Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item The Virtio SPI driver configures and initializes the virtqueue.
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / SPI Master 
>> Device / Device Operation}
>> +
>> +\subsubsection{Device Operation: Request Queue}\label{sec:Device 
>> Types / SPI Master Device / Device Operation: Request Queue}
>> +
>> +Virtio SPI driver enqueues requests to the virtqueue, and they are 
>> used by
>> +Virtio SPI device. Each request represents one SPI tranfer and is of 
>> the form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_head {
>> +        u8 slave_id;
>> +        u8 bits_per_word;
>> +        u8 cs_change;
>> +        u8 tx_nbits;
>> +        u8 rx_nbits;
>> +     u8 reserved[3];
> You may not see it in your E-Mail client, but there is a tab in front of 
> "u8 reserved[3];" instead of spaces. This destroys the formatting of the 
> generated PDF.

Will avoid alignment case in next patch.

>> +        le32 mode;
>> +        le32 freq;
>> +        le32 word_delay_ns;
>> +        le32 cs_setup_ns;
>> +        le32 cs_delay_hold_ns;
>> +        le32 cs_change_delay_inactive_ns;
>> +};
>> +\end{lstlisting}
> 
> I see a virtqueue as a communication channel over which all kinds of 
> messages can be transferred. The existing message may have to be 
> enhanced in the future in some way nobody today thinks about with the 
> outcome that we may have in the future the need to distinguish between 
> different kinds of messages.
> 
> Adding a flags field or a message type at the top of struct 
> virtio_spi_transfer_head to become more future proof? It may never be 
> needed, so I'm also fine without this small addition but it is worth to 
> think about this for some minutes.
> 

I have considered this topic before, introducing another config 
virtqueue, used to exchange config information. Just some tips:
1) all parameters in config virtqueue can be held in spi transfer header.
2) two virtqueues may have conflicts?
3) will make the driver code more complicated.
4) hard to define which parameters passed via config queue and which 
parameters passed via transfer queue.

>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_result {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_req {
>> +        struct virtio_spi_transfer_head head;
>> +        u8 tx_buf[];
>> +        u8 rx_buf[];
>> +        struct virtio_spi_transfer_result result;
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{slave_id} indicates the chipselect index the SPI transfer 
>> used.
>> +
>> +The \field{bits_per_word} indicates the number of bits in each SPI 
>> transfer word.
>> +
>> +The \field{cs_change} indicates whether to deselect device before 
>> starting the
>> +next SPI transfer, 0 means chipselect keep asserted and 1 means 
>> chipselect deasserted
>> +then asserted again.
>> +
>> +The \field{tx_nbits} indicates bus width for write transfer:
>> +        0,1: bus width is 1, also known as SINGLE;
>> +    2  : bus width is 2, also known as DUAL;
>> +    4  : bus width is 4, also known as QUAD;
>> +    8  : bus width is 8, also known as OCTAL;
>> +    other values are invalid.
>> +
>> +The \field{rx_nbits} indicates bus width for read transfer:
>> +        0,1: bus width is 1, also known as SINGLE;
>> +    2  : bus width is 2, also known as DUAL;
>> +    4  : bus width is 4, also known as QUAD;
>> +    8  : bus width is 8, also known as OCTAL;
>> +    other values are invalid.
>> +
>> +The \field{reserved} is for alignement, also for further extension.
> 
> alignment
yes.
> 
>> +
>> +The \field{mode} indicates how data is clocked out and in. Bit 
>> definitions as follows:
>> +        bit 0: CPHA, determines the timing (i.e. phase) of the data bits
>> +           relative to the clock pulses.
>> +        bit 1: CPOL, determines the polarity of the clock.
>> +        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
>> +    bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
>> +           first, else LSB first.
>> +    bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
>> +
>> +The \field{freq} indicates the SPI transfer speed in Hz.
>> +
>> +The \field{word_delay_ns} indicates delay to be inserted between 
>> consecutive
>> +words of a transfer, in ns unit.
>> +
>> +The \field{cs_setup_ns} indicates delay to be introduced after 
>> chipselect
>> +is asserted, in ns unit.
>> +
>> +The \field{cs_delay_hold_ns} indicates delay to be introduced before 
>> chipselect
>> +is deasserted, in ns unit.
>> +
>> +The \field{cs_change_delay_inactive_ns} indicates delay to be 
>> introduced after
>> +chipselect is deasserted and before next asserted, in ns unit.
>> +
>> +The \field{tx_buf} is the buffer for data sent to the device.
>> +
>> +The \field{rx_buf} is the buffer for data received to the device.
>> +
>> +The final \field{result} is the transfer result, either 
>> VIRTIO_SPI_TRANS_OK for success
>> +or VIRTIO_SPI_TRANS_ERR for error.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_SPI_TRANS_OK     0
>> +#define VIRTIO_SPI_TRANS_ERR    1
>> +\end{lstlisting}
>> +
>> +\subsubsection{Device Operation: Operation Status}\label{sec:Device 
>> Types / SPI Master Device / Device Operation: Operation Status}
>> +
>> +Fields in structure \field{virtio_spi_transfer_head} are written by 
>> Virtio SPI driver, while
>> +\field{result} in structure \field{virtio_spi_transfer_result} is 
>> written by Virtio SPI device.
>> +
>> +virtio-spi supports three transfer types:
>> +        1) half-duplex read;
>> +        2) half-duplex write;
>> +        3) full-duplex read and write.
>> +
>> +For half-duplex read transfer, \field{rx_buf} is filled by Virtio SPI 
>> device and consumed
>> +by Virtio SPI driver. For half-duplex write transfer, \field{tx_buf} 
>> is filled by Virtio
>> +SPI driver and consumed by Virtio SPI device. And for full-duplex 
>> read and write transfer,
>> +both \field{tx_buf} and \field{rx_buf} are used.
>> +
>> +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI 
>> Master Device / Device Operation}
>> +
>> +The Virtio SPI driver MUST send transfer requests on the requestq 
>> virtqueue.
>> +
>> +Fields in structure \field{virtio_spi_transfer_head} MUST be filled 
>> by Virtio SPI driver
>> +and MUST be readable for Virtio SPI device.
>> +
>> +Structure \field{virtio_spi_transfer_result} MUST be filled by Virtio 
>> SPI device
>> +and MUST be writable for Virtio SPI device.
>> +
>> +For half-duplex read, Virtio SPI driver MUST send structure 
>> \field{virtio_spi_transfer_head},
>> +\field{rx_buf} and structure \field{virtio_spi_transfer_result} to 
>> SPI Virtio Device in order.
>> +
>> +For half-duplex write, Virtio SPI driver MUST send structure 
>> \field{virtio_spi_transfer_head},
>> +\field{tx_buf} and structure \field{virtio_spi_transfer_result} to 
>> SPI Virtio Device in order.
>> +
>> +For full-duplex read and write, Virtio SPI driver MUST send structure 
>> \field{virtio_spi_transfer_head},
>> +\field{tx_buf}, \field{rx_buf} and structure 
>> \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
>> +
>> +For half-duplex write or full-duplex read and write transfer, Virtio 
>> SPI driver MUST not use \field{rx_buf}
>> +if the \field{result} returned from Virtio SPI device is 
>> VIRTIO_SPI_TRANS_ERR.
>> +
>> +If \field{cs_timing_setting_enable} in structure 
>> \field{virtio_spi_config} is 0, while \field{cs_setup_ns},
>> +\field{cs_setup_ns} and \field{cs_change_delay_inactive_ns} of the 
>> transfer are not all zero, Virtio
>> +SPI driver MUST print a warning log to alert that the cs timing won't 
>> be set as expected.
> 
> We are talking about
> 
>      __le32 word_delay_ns;
>      __le32 cs_setup_ns;
>      __le32 cs_delay_hold_ns;
>      __le32 cs_change_delay_inactive_ns;
> 
> 1.) cs_setup_ns is a duplicate. cs_delay_hold_ns is missing. 
> word_delay_ns is also missing!
yes!
> 
> 2.) There is on Linux no problem with cs_change_delay_inactive_ns. For 
> e.g. 4.14 this is in struct spi_transfer xfer the member delay_usecs, 
> for latest kernels this is delay (or cs_change_delay, currently unsure). 
> There should also be no problem to have this because on every platform 
> after a SPI transaction has been completed such a delay could be 
> introduced simply by calling some Delay() function. This one probably 
> can be supported everywhere.
> 
> 2.) The most important field, le32 word_delay_ns is also missing.
> 
>        - This one has nothing to do with CS, so the config space name 
> prefixed by cs_ is misnamed
>        - I have no idea how to support this word_delay_ns on older Linux 
> versions and on some hardware platforms
> 

I want separate these 4 values into 2 groups:

     group 1: word_delay_ns;
     group 2: cs_setup_ns, cs_delay_hold_ns, cs_change_delay_inactive_ns

group 1 is unrelated to CS, cause when this group takes effect, CS keeps 
as active.

group 2 always takes effect when CS changes, asserted or deasserted.

Considering this rules, cs_timing_setting_enable in config space only 
apply to group 2. group 1 can be easily supported by the virtio SPI 
device, by software Delay() and so on. But for group 2, not all SPI 
controllers support CS timing delay setting, software cannot do this even.

Maybe I should explain clearly in cs_timing_setting_enable field?

> 3.) Logging a warning. This is an unusual requirement. When the driver 
> can know from the config space it should handle according to the 
> information it got from there. I propose to get somewhat harder here.
> 
> Device requirement: The device MUST reject a message by some tbd error 
> if tbd delay timing is not supported but the requested value is not zero .
> 
> Driver requirement: If the device did not announce support of tbd delay 
> timings in the config space the driver SHOULD not sent a delay timing 
> not equal to zero but should immediately reject the message.
> 

Yes! I will update in next patch, stricter and harder seem much better.

> And I think best is not to define 0 and 1 for cs_timing_setting_enable but
> 
> #define SPI_HAVE_WORD_DELAY 0x01
> #define SPI_HAVE_CS_SETUP 0x02
> #define SPI_HAVE_CS_HOLD 0x04
> #define SPI_HAVE_CS_CHANGE_INACTIVE 0x08 /* Only if not required to be 
> supported always by the device */
> 
> so the driver knows the delays supported by the device exactly.
> 

good idea, each bit represents one cs timing parameter.

> BTW, in my driver code I have currently still a problem with the 
> mappings of
> 
>      __le32 word_delay_ns;
>      __le32 cs_setup_ns;
>      __le32 cs_delay_hold_ns;
>      __le32 cs_change_delay_inactive_ns;
> 
> to Linux struct spi_transfer word_delay, delay, cs_change_delay.
> 
> 4 values to be filled in struct spi_transfer_head from 3 values in 
> struct spi_transfer of latest Linux. Maybe I just did not get from where 
> to get cleanly the 4th value even from the newest Linux driver environment.
> 
> We have between Linux 4.14 and latest some intermediate states in struct 
> spi_transfer and someone (could be me) may have to cope with this.

I look into the latest Linux spi driver, and find these delay values:
     struct spi_device -> word_delay
     struct spi_device -> cs_setup
     struct spi_device -> cs_hold
     struct spi_device -> cs_inactive
     struct spi_transfer -> delay
     struct spi_transfer -> cs_change_delay
     struct spi_transfer -> word_delay

I take spi_transfer_one_message function in drivers/spi/spi.c to analyze 
these values take effect at which stage. Consider a condition, one 
spi_message contains two spi_transfer, cs is controlled as GPIO, and for 
the first transfer, cs_change is true which for the second cs_change 
false. Just ingoring some strange setting not used commonly, such as cs_off.

       .   .      .    .    .   .   .   .   .   .
Delay + A +      + B  +    + C + D + E + F + A +
       .   .      .    .    .   .   .   .   .   .
    ___.   .      .    .    .   .   .___.___.   .
CS#   |___.______.____.____.___.___|   .   |___._____________
       .   .      .    .    .   .   .   .   .   .
       .   .      .    .    .   .   .   .   .   .
SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______


NOTE: 1st transfer has two words, the delay betweent these two words are 
'B' in the diagram.

A => struct spi_device -> cs_setup
B => max{struct spi_transfer -> word_delay,
          struct spi_device -> word_delay}
     Note: spi_device and spi_transfer both have word_delay, Linux
          choose the bigger one, refer to _spi_xfer_word_delay_update 

          function
C => struct spi_transfer -> delay
D => struct spi_device -> cs_hold
E => struct spi_device -> cs_inactive
F => struct spi_transfer -> cs_change_delay

So the corresponding relationship:
A <===> cs_setup_ns (after CS asserted)
B <===> word_delay_ns (no matter with CS)
C+D <===> cs_delay_hold_ns (before CS deasserted)
E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two 
values also recommend in Linux driver to be added up)

It's quite possible that the host is not Linux and doesn't recognize 
these separate paramters, I add the values at the same stages(C and D, E 
and F), this makes sense I think.

> 
>> +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI 
>> Master Device / Device Operation}
>> +
>> +Virtio SPI device MUST set all the fields of the structure 
>> \field{virtio_spi_config} before
>> +they are read by Virtio SPI driver.
>> +
>> +Virtio SPI device MUST set the structure 
>> \field{virtio_spi_transfer_result} before sending
>> +it back to Virtio SPI driver.
>> +
>> +Virtio SPI device MUST be able to identify the transfer type 
>> according to the received
>> +virtqueue descriptors.
>> +
>> +Virtio SPI device MUST NOT change the data in \field{tx_buf} if 
>> transfer type is half-duplex write
>> +or full-duplex read and write.
>> diff --git a/device-types/spi/device-conformance.tex 
>> b/device-types/spi/device-conformance.tex
>> new file mode 100644
>> index 0000000..3e771bc
>> --- /dev/null
>> +++ b/device-types/spi/device-conformance.tex
>> @@ -0,0 +1,7 @@
>> +\conformance{\subsection}{SPI Master Device 
>> Conformance}\label{sec:Conformance / Device Conformance / SPI Master 
>> Device Conformance}
>> +
>> +An SPI Master device MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / SPI Master Device / Device 
>> Operation}
>> +\end{itemize}
>> diff --git a/device-types/spi/driver-conformance.tex 
>> b/device-types/spi/driver-conformance.tex
>> new file mode 100644
>> index 0000000..3c965ef
>> --- /dev/null
>> +++ b/device-types/spi/driver-conformance.tex
>> @@ -0,0 +1,7 @@
>> +\conformance{\subsection}{SPI Master Driver 
>> Conformance}\label{sec:Conformance / Driver Conformance / SPI Master 
>> Driver Conformance}
>> +
>> +An SPI Master driver MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{drivernormative:Device Types / SPI Master Device / Device 
>> Operation}
>> +\end{itemize}
> 
> We may discuss further based on code, internal paperwork done so the 
> Linux driver which was done internally at OpenSynergy can go out now as 
> RFC as well.

Sure. Looking forward to discussing futher based on code and spec.

Thanks again for your comments and ideas.

Best Regards
Haixu Cui
> 
> Regards
> Harald Mommer
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

