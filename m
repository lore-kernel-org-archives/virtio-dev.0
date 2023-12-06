Return-Path: <virtio-dev-return-14125-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7116C4167B
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 06:08:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 76E871FF75
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 06:08:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C8D398682A
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 06:08:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 50DD2984043; Wed,  6 Dec 2023 06:08:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4108D98669F;
	Wed,  6 Dec 2023 06:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <1fe07824-dd0d-4393-8f86-26b494676603@quicinc.com>
Date: Wed, 6 Dec 2023 14:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231205082401.18111-1-quic_haixcui@quicinc.com>
 <20231205082401.18111-3-quic_haixcui@quicinc.com>
 <b9d86f18-3e7b-4a51-a7c3-d9044dc567ba@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <b9d86f18-3e7b-4a51-a7c3-d9044dc567ba@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PbOyh5xOcudMjUbqNzgfz_GvEGMYO-QD
X-Proofpoint-GUID: PbOyh5xOcudMjUbqNzgfz_GvEGMYO-QD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_04,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060048
Subject: Re: [virtio-dev][PATCH V8 2/2] virtio-spi: add the device
 specification

Hello Harald,

On 12/6/2023 12:18 AM, Harald Mommer wrote:
> Hello,
> 
> updating my device and driver to V8 and having some comments now.
> 
> On 05.12.23 09:24, Haixu Cui wrote:
>> The Virtio SPI (Serial Peripheral Interface) device is a virtual
>> SPI controller that allows the driver to operate and use the SPI
>> controller under the control of the host.
>>
>> This patch adds the specification for virtio-spi.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   device-types/spi/description.tex        | 280 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 +
>>   device-types/spi/driver-conformance.tex |   7 +
>>   3 files changed, 294 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
>>
>> diff --git a/device-types/spi/description.tex 
>> b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..ef686bd
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,280 @@
>> +\section{SPI Controller Device}\label{sec:Device Types / SPI 
>> Controller Device}
>> +
>> +The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI 
>> controller that
>> +allows the driver to operate and use the SPI controller under the 
>> control of the host,
>> +either a physical SPI controller, or an emulated one.
>> +
>> +The Virtio SPI device has a single virtqueue. SPI transfer requests 
>> are placed into
>> +the virtqueue by the driver, and are serviced by the device.
>> +
>> +In a typical host and guest architecture with the Virtio SPI device, 
>> the Virtio SPI driver
>> +is the front-end running in the guest, and the Virtio SPI device is 
>> the back-end
>> +in the host.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / SPI Controller Device 
>> / Device ID}
>> +45
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / SPI Controller 
>> Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] requestq
>> +\end{description}
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / SPI Controller 
>> Device / Feature bits}
>> +
>> +None
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / SPI 
>> Controller Device / Device configuration layout}
>> +
>> +All fields of this configuration are mandatory and read-only for the 
>> driver.
>> +The config space shows the features and settings supported by the 
>> device.
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_config {
>> +    u8 cs_max_number;
>> +    u8 cs_change_supported;
>> +    u8 tx_nbits_supported;
>> +    u8 rx_nbits_supported;
>> +    le32 bits_per_word_mask;
>> +    le32 mode_func_supported;
>> +    le32 max_freq_hz;
>> +    le32 max_word_delay_ns;
>> +    le32 max_cs_setup_ns;
>> +    le32 max_cs_hold_ns;
>> +    le32 max_cs_inactive_ns;
>> +};
>> +\end{lstlisting}
>> +
>> +\field{cs_max_number} is the maximum number of chipselect the device 
>> supports.
>> +
>> +Note: chipselect is an electrical signal, which is used to select the 
>> SPI slaves connected
>> +to the controller.
>> +
>> +\field{cs_change_supported} indicates if the device supports to 
>> toggle chipselect
>> +after each transfer in one message:
>> +        0: unsupported, chipselect will be kept in active state 
>> throughout the message transaction;
>> +        1: supported.
>> +
>> +Note: Message here contains a sequence of SPI transfers.
>> +
>> +\field{tx_nbits_supported} and \field{rx_nbits_supported} indicate 
>> the different n-bit transfer
>> +modes supported by the device, for writing and reading respectively. 
>> SINGLE is always supported.
>> +A set bit here indicates that the corresponding n-bit transfer is 
>> supported, otherwise not:
>> +        bit 0: DUAL;
>> +        bit 1: QUAD;
>> +        bit 2: OCTAL;
>> +        other bits are reserved and must be set as 0 by the device.
>> +
>> +Note: The commonly used SPI n-bit transfer options are:
>> +\begin{itemize}
>> +\item SINGLE: 1-bit transfer
>> +\item DUAL: 2-bit transfer
>> +\item QUAD: 4-bit transfer
>> +\item OCTAL: 8-bit transfer
>> +\end{itemize}
>> +
>> +\field{bits_per_word_mask} is a mask indicating which values of 
>> bits_per_word are supported.
>> +If not set, there is no limitation for bits_per_word.
> 
> You have not given an exact coding here. Without this it's hard to 
> understand what is really specified and guesswork is needed.
> 
> 1.) In Linux in spi.h there is a definition
> 
>      /* Bitmask of supported bits_per_word for transfers */
>      u32            bits_per_word_mask;
> #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> 
> which brings us probably on the wrong path. Not sure any more. With this 
> coding you can have 1..32 as bits per word. 0 is not allowed for 
> bits_per_word_mask, at least it seems not to be used.
> 
> What you probably (guessing around) wanted to have is
> 
> #define VIRTIO_SPI_BPW_MASK(bits) ((u32)(1UL << (bits)))
> 
> without the - 1 as you specified 0 as "unlimited". In this case you can 
> define every value from 1 to 31. 32 and above is "unlimited" as for 32 
> and above (u32)(1UL << (bits)) == 0u.
> 
> I'm lost.
> 
> 2.) "No limitation" is nonsense on a limited machine. Even the universe 
> is limited (at least the observable one), for sure your RAM is. And also 
> the definition in Linux is limited to 32.
> 
> ===
> 
> *** What Linux can do with it's coding is to define the mask in a way to 
> indicate that 8, 16 and 32 bit transfers are supported. With the other 
> coding without the - 1 this cannot be done! ***
> 
> => I STRONGLY recommend to use the coding as done by using 
> SPI_BPW_MASK() in Linux and to specify this clearly!
> 

Yes, here I want to use the SPI_BPW_MASK method directly but so sorry to 
make it unclear.

I will update the statement as follows:

"\field{bits_per_word_mask} is a mask indicating which values of 
bits_per_word are supported.
If bit n of \field{bits_per_word_mask} is set, the bits_per_word with 
value (n+1) is supported.
If all bits are not set, bits_per_word can be any value from 1 to 32."

Do you think that's ok? Looking forward to your comments.

>> +
>> +Note: bits_per_word corresponds to \field{bits_per_word} in 
>> \field{struct virtio_spi_transfer_head}.
>> +
>> +\field{mode_func_supported} indicates whether the following features 
>> are supported or not:
>> +        bit 0-1: CPHA feature,
>> +            0b00: supports CPHA=0 and CPHA=1;
>> +            0b01: supports CPHA=0 only;
>> +            0b10: supports CPHA=1 only;
>> +            0b11: invalid, must support as least one CPHA setting.
>> +
>> +        bit 2-3: CPOL feature,
>> +            0b00: supports CPOL=0 and CPOL=1;
>> +            0b01: supports CPOL=0 only;
>> +            0b10: supports CPOL=1 only;
>> +            0b11: invalid, must support as least one CPOL setting.
> 
> This definition 0b00 = Support all instead of 0b11 = Support all makes 
> my code more complicated.
> 
> - On the device side as I now query both bits having in the end 0x3 or 
> 0xC and if both bits are set after querying I've to clear them 
> afterwards to get the desired coding
> 
> - I can also not check by querying a single bit whether for example 
> CPHA=0 is supported. No, I have to check for both bits being 0 or for 
> bit 0 set.
> 
> => Getting additional and more complicated code by some unlucky coding 
> choice in the specification.
> 
> Proposal: Make 0b00 invalid, allow 0b11 for "everything supported" for 
> CPHA AND CPOL.
> 

Fine with me. I will update CPHA and CPOL as follows:

         bit 0-1: CPHA feature,
             0b00: invalid, must support as least one CPHA setting.
             0b01: supports CPHA=0 only;
             0b10: supports CPHA=1 only;
             0b11: supports CPHA=0 and CPHA=1;

         bit 2-3: CPOL feature,
             0b00: invalid, must support as least one CPOL setting.
             0b01: supports CPOL=0 only;
             0b10: supports CPOL=1 only;
             0b11: supports CPOL=0 and CPOL=1;


Thank you for your comments. Much appreciated.


Best Regards
Haixu Cui
>> +
>> +        bit 4: chipselect active high feature, 0 for unsupported and 
>> 1 for supported,
>> +            chipselect active low must always be supported.
>> +
>> +        bit 5: LSB first feature, 0 for unsupported and 1 for 
>> supported, MSB first must always be
>> +            supported.
>> +
>> +        bit 6: loopback mode feature, 0 for unsupported and 1 for 
>> supported, normal mode
>> +            must always be supported.
>> +
>> +Note: CPOL is clock polarity and CPHA is clock phase. If CPOL is 0, 
>> the clock idles at the logical
>> +low voltage, otherwise it idles at the logical high voltage. CPHA 
>> determines how data is outputted
>> +and sampled.
>> +
>> +Note: LSB first indicates that data is transferred least significant 
>> bit first, and MSB first
>> +indicates that data is transferred most significant bit first.
>> +
>> +\field{max_freq_hz} is the maximum clock rate supported in Hz unit, 0 
>> means no limitation
>> +for transfer speed.
>> +
>> +\field{max_word_delay_ns} is the maximum word delay supported in ns 
>> unit, 0 means word delay
>> +feature is unsupported.
>> +
>> +Note: Just as one message contains a sequence of transfers, one 
>> transfer may contain
>> +a sequence of words.
>> +
>> +\field{max_cs_setup_ns} is the maximum delay supported after 
>> chipselect is asserted, in ns unit,
>> +0 means delay is not supported to introduce after chipselect is 
>> asserted.
>> +
>> +\field{max_cs_hold_ns} is the maximum delay supported before 
>> chipselect is deasserted, in ns unit,
>> +0 means delay is not supported to introduce before chipselect is 
>> deasserted.
>> +
>> +\field{max_cs_incative_ns} is the maximum delay supported after 
>> chipselect is deasserted, in ns unit,
>> +0 means delay is not supported to introduce after chipselect is 
>> deasserted.
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / SPI 
>> Controller Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item The Virtio SPI driver configures and initializes the virtqueue.
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / SPI Controller 
>> Device / Device Operation}
>> +
>> +\subsubsection{Device Operation: Request Queue}\label{sec:Device 
>> Types / SPI Controller Device / Device Operation: Request Queue}
>> +
>> +The Virtio SPI driver enqueues requests to the virtqueue, and they 
>> are used by the Virtio SPI device.
>> +Each request represents one SPI transfer and is of the form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_head {
>> +        u8 chip_select_id;
>> +        u8 bits_per_word;
>> +        u8 cs_change;
>> +        u8 tx_nbits;
>> +        u8 rx_nbits;
>> +        u8 reserved[3];
>> +        le32 mode;
>> +        le32 freq;
>> +        le32 word_delay_ns;
>> +        le32 cs_setup_ns;
>> +        le32 cs_delay_hold_ns;
>> +        le32 cs_change_delay_inactive_ns;
>> +};
>> +\end{lstlisting}
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
>> +\field{chip_select_id} indicates the chipselect index to use for the 
>> SPI transfer.
>> +
>> +\field{bits_per_word} indicates the number of bits in each SPI 
>> transfer word.
>> +
>> +\field{cs_change} indicates whether to deselect device before 
>> starting the next SPI transfer,
>> +0 means chipselect keep asserted and 1 means chipselect deasserted 
>> then asserted again.
>> +
>> +\field{tx_nbits} and \field{rx_nbits} indicate n-bit transfer mode 
>> for writing and reading:
>> +        0,1: SINGLE;
>> +        2  : DUAL;
>> +        4  : QUAD;
>> +        8  : OCTAL;
>> +        other values are invalid.
>> +
>> +\field{reserved} is currently unused and might be used for further 
>> extensions in the future.
>> +
>> +\field{mode} indicates some transfer settings. Bit definitions as 
>> follows:
>> +        bit 0: CPHA, determines the timing (i.e. phase) of the data 
>> bits relative to the
>> +           clock pulses.
>> +        bit 1: CPOL, determines the polarity of the clock.
>> +        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
>> +        bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB 
>> first, else LSB first.
>> +        bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
>> +
>> +\field{freq} indicates the SPI transfer speed in Hz.
>> +
>> +\field{word_delay_ns} indicates delay to be inserted between 
>> consecutive words of a transfer,
>> +in ns unit.
>> +
>> +\field{cs_setup_ns} indicates delay to be introduced after chipselect 
>> is asserted, in ns unit.
>> +
>> +\field{cs_delay_hold_ns} indicates delay to be introduced before 
>> chipselect is deasserted,
>> +in ns unit.
>> +
>> +\field{cs_change_delay_inactive_ns} indicates delay to be introduced 
>> after chipselect is
>> +deasserted and before next asserted, in ns unit.
>> +
>> +\field{tx_buf} is the buffer for data sent to the device.
>> +
>> +\field{rx_buf} is the buffer for data received from the device.
>> +
>> +\field{result} is the transfer result, it may be one of the following 
>> values:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_SPI_TRANS_OK     0
>> +#define VIRTIO_SPI_PARAM_ERR    1
>> +#define VIRTIO_SPI_TRANS_ERR    2
>> +\end{lstlisting}
>> +
>> +VIRTIO_SPI_TRANS_OK indicates successful completion of the transfer.
>> +
>> +VIRTIO_SPI_PARAM_ERR indicates a parameter error, which means the 
>> parameters in
>> +\field{struct virtio_spi_transfer_head} are not all valid, or some 
>> fields are set as
>> +non-zero values but the corresponding features are not supported by 
>> device.
>> +In particular, for full-duplex transfer, VIRTIO_SPI_PARAM_ERR can 
>> also indicate that
>> +\field{tx_buf} and \field{rx_buf} are not of the same length.
>> +
>> +VIRTIO_SPI_TRANS_ERR indicates a transfer error, which means that the 
>> parameters are all
>> +valid but the trasnfer process failed.
>> +
>> +\subsubsection{Device Operation: Operation Status}\label{sec:Device 
>> Types / SPI Controller Device / Device Operation: Operation Status}
>> +
>> +Fields in \field{struct virtio_spi_transfer_head} are written by the 
>> Virtio SPI driver, while
>> +\field{result} in \field{struct virtio_spi_transfer_result} is 
>> written by the Virtio SPI device.
>> +
>> +virtio-spi supports three transfer types:
>> +\begin{itemize}
>> +\item half-duplex read;
>> +\item half-duplex write;
>> +\item full-duplex transfer.
>> +\end{itemize}
>> +
>> +For half-duplex read and full-duplex transfer, \field{rx_buf} is 
>> filled by the Virtio SPI device
>> +and consumed by the Virtio SPI driver. For half-duplex write and 
>> full-duplex transfer, \field{tx_buf}
>> +is filled by the Virtio SPI driver and consumed by the Virtio SPI 
>> device.
>> +
>> +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI 
>> Controller Device / Device Operation}
>> +
>> +For half-duplex read, the Virtio SPI driver MUST send \field{struct 
>> virtio_spi_transfer_head},
>> +\field{rx_buf} and \field{struct virtio_spi_transfer_result} to the 
>> SPI Virtio Device in that order.
>> +
>> +For half-duplex write, the Virtio SPI driver MUST send \field{struct 
>> virtio_spi_transfer_head},
>> +\field{tx_buf} and \field{struct virtio_spi_transfer_result} to the 
>> SPI Virtio Device in that order.
>> +
>> +For full-duplex transfer, the Virtio SPI driver MUST send 
>> \field{struct virtio_spi_transfer_head},
>> +\field{tx_buf}, \field{rx_buf} and \field{struct 
>> virtio_spi_transfer_result} to the SPI Virtio Device
>> +in that order.
>> +
>> +For full-duplex transfer, the Virtio SPI driver MUST guarantee that 
>> the buffer size of \field{tx_buf}
>> +and \field{rx_buf} is the same.
>> +
>> +The Virtio SPI driver MUST not use \field{rx_buf} if the 
>> \field{result} returned from the Virtio SPI device is
>> +not VIRTIO_SPI_TRANS_OK.
>> +
>> +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI 
>> Controller Device / Device Operation}
>> +
>> +The Virtio SPI device MUST set all the fields of \field{struct 
>> virtio_spi_config} before they are
>> +read by the Virtio SPI driver.
>> +
>> +The Virtio SPI device MUST NOT change the data in \field{tx_buf}.
>> +
>> +The Virtio SPI device MUST verify the parameters in \field{struct 
>> virtio_spi_transfer_head} after receiving
>> +the request, and MUST set \field{struct virtio_spi_transfer_result} 
>> as VIRTIO_SPI_PARAM_ERR if not all
>> +parameters are valid or some device unsupported features are set.
>> +
>> +For full-duplex transfer, the Virtio SPI device MUST verify that the 
>> buffer size of \field{tx_buf} is equal to
>> +that of \field{rx_buf}. If not, the Virtio SPI device MUST set 
>> \field{struct virtio_spi_transfer_result}
>> +as VIRTIO_SPI_PARAM_ERR.
>> diff --git a/device-types/spi/device-conformance.tex 
>> b/device-types/spi/device-conformance.tex
>> new file mode 100644
>> index 0000000..4509156
>> --- /dev/null
>> +++ b/device-types/spi/device-conformance.tex
>> @@ -0,0 +1,7 @@
>> +\conformance{\subsection}{SPI Controller Device 
>> Conformance}\label{sec:Conformance / Device Conformance / SPI 
>> Controller Device Conformance}
>> +
>> +An SPI Controller device MUST conform to the following normative 
>> statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / SPI Controller Device / 
>> Device Operation}
>> +\end{itemize}
>> diff --git a/device-types/spi/driver-conformance.tex 
>> b/device-types/spi/driver-conformance.tex
>> new file mode 100644
>> index 0000000..bbd1967
>> --- /dev/null
>> +++ b/device-types/spi/driver-conformance.tex
>> @@ -0,0 +1,7 @@
>> +\conformance{\subsection}{SPI Controller Driver 
>> Conformance}\label{sec:Conformance / Driver Conformance / SPI 
>> Controller Driver Conformance}
>> +
>> +An SPI Controller driver MUST conform to the following normative 
>> statements:
>> +
>> +\begin{itemize}
>> +\item \ref{drivernormative:Device Types / SPI Controller Device / 
>> Device Operation}
>> +\end{itemize}
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

