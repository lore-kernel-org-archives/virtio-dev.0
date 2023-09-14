Return-Path: <virtio-dev-return-13757-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA75EDE988
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 06:58:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3BE8E2A826
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 06:58:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AF89986653
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 06:58:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1D27198663D; Thu, 14 Sep 2023 06:58:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 007EB986639;
	Thu, 14 Sep 2023 06:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <4fc72eb9-51ba-9ef8-d4c5-a1a435deab86@quicinc.com>
Date: Thu, 14 Sep 2023 14:57:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <quic_ztu@quicinc.com>, <jrreinhart@google.com>,
        Mikhail Golubev
	<Mikhail.Golubev@opensynergy.com>
References: <20230901032933.32434-1-quic_haixcui@quicinc.com>
 <cb119016-decc-51dd-aabe-0326b339212e@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <cb119016-decc-51dd-aabe-0326b339212e@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nSiovBZrNifxOi1X0HAlLheV-KaTIOEI
X-Proofpoint-GUID: nSiovBZrNifxOi1X0HAlLheV-KaTIOEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140061
Subject: [virtio-dev] Re: [PATCH v3] virtio-spi: add the device specification

Hello Harald Mommer,

     Thank you so much for your comments and please refer to my 
following reply.

On 9/6/2023 9:50 PM, Harald Mommer wrote:
> Hello Haixu Cui,
> 
> On 01.09.23 05:29, Haixu Cui wrote:
>> virtio-spi is a virtual SPI master and it allows a guset to operate and
> guest

Yes, spell error.

>> use the physical SPI master controlled by the host.
>>
>> This patch adds the specification for virtio-spi.
>>
>> Signed-off-by: Haixu Cui<quic_haixcui@quicinc.com>
>> ---
>>   device-types/spi/description.tex        | 191 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 +
>>   device-types/spi/driver-conformance.tex |   7 +
>>   3 files changed, 205 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
>>
>> diff --git a/device-types/spi/description.tex 
>> b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..c35826b
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,191 @@
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
>> +    le32 bus_num;
> 
> Just a remark: In some environments (Linux) not the complete value range 
> of bus_num can be used. For example in Linux 0 <= bus_num <= S16_MAX.
> 
>> +    le32 chip_select_max_number;
> 
> Just a remark: In some environments (Linux) not the complete value range 
> of chip_select_max_number can be used. For example in Linux 0 <= bus_num 
> <= U16_MAX.
> 
> And subsequently slave_id is an u8 and must be in the range 
> 0..chip_select_max_number - 1.
> 
> If wanted, a le16 for both fields may be considered sufficient. We are 
> hopefully not this scarce on bytes, so it does not really matter. I just 
> wanted to mention especially for the 2nd field here.
> 

In spi_controller structure, bus_num and number_chipselect are both 16 
bits, so le16 is enough. Will update.

>> +};
>> +\end{lstlisting}
>> +
>> +The \field{bus_num} indicates the physical SPI master assigned to 
>> guset, and this is SOC-specific.
> guest. And why is this SOC-specific? On Linux this is the 1234 in 
> /dev/spidev1234.x when bus_num is set to 1234 by the virtio device. So 
> it's purpose is to distinguish the different /dev/spidev when more than 
> only a single virtio SPI device is provided to the driver guest. But 
> SOC-specific?

Yes, this is set by the back-end. "SOC-specific" is not appropriate. 
Will remove it.

>> +
>> +The \field{chip_select_max_number} is the maximum number of 
>> chipselect the physical SPI master supports.
> Was without "maximum" in the text of the last version. What should 
> happen in my Linux driver implementation is that there should be exactly 
> this number of /dev/spidev1234.x device files. with x = 
> 0..chip_select_max_number -1.

Well, so if your back-end set this filed to 1, then your virtual spi is 
/dev/spidev1234.1?
But how do you know spi master supports how many chipselect lines? I 
think num_chipselect in spi_controller must be set correctly otherwise 
it will return -EINVAL when running spi_register_controller.

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
> As already mentioned, u8 reserved[3] missing here not necessarily for 
> future use but for alignment. Might be a good idea to require that those 
> reserved bytes shall be set to 0 by the driver.

That is a goot point.

>> +        le32 mode;
>> +        le32 freq;
>> +        le32 word_delay_ns;
>> +        le32 cs_setup_ns;
>> +        le32 cs_delay_hold_ns;
> As already said, the last 3 fields may be difficult to support in some 
> environments and some hint what to do in this case is appreciated.

I came up with two options:

1. Add another field in configuration space, to declare if the hardware 
supports chipselect timing setting. If hardware doesn't support while 
these chipselect are not 0, then the driver throw a warning.

2. Add another result value, for example VIRTIO_SPI_TRANS_OK_CS_ERR. If 
these three fileds are not 0 but back-end hardware doesn't support 
chipselect timing setting, then the back-end ignores these fileds and 
performs transfer, if transfer is success, then return 
VIRTIO_SPI_TRANS_OK_CS_ERR.

Which option is better? Or any other ideas?
I would like to hear your views.

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
>> +The \field{mode} indicates how data is clocked out and in. Bit 
>> definitions as follows:
>> +        bit 0: CPHA, determines the timing (i.e. phase) of the data bits
>> +           relative to the clock pulses.
>> +        bit 1: CPOL, determines the polarity of the clock.
>> +        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
>> +    bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
>> +           first, else LSB first.
>> +    bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
> 
> Subset of what Linux has: SPI_3WIRE, SPI_NO_CS and SPI_READY and more 
> recently SPI_3WIRE_HIZ, SPI_RX_CPHA_FLIP and SPI_MOSI_IDLE_LOW. What's 
> defined in Linux but is not available here seems to be more strange 
> stuff not widely in use so most probably nothing important has been 
> forgotten. Fine.
> 
> Looking into my driver code some things I had to set in the hard coded way
> 
> master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
>              SPI_LOOP | SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL |
>              SPI_RX_QUAD;
> 
> "master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);"
> 
> without knowing exactly whether all this is supported in the end by the 
> virtio SPI device. The driver may announce a superset of what's actually 
> really supported by the backend device.
> 
> However having more information available in the config space would 
> complicate the specification and is probably not being worth to be done. 
> User code using the virtio driver should know very well anyway what's 
> really supported without having any additional config space information. 
> Should be good enough.

Yes, other settings like SPI_3WIRE_HIZ, SPI_NO_CS seems not widely used, 
only for some very special scenario. So I didn't involve these settings.

When meetting this special scenario, I think it is easy to implement 
extensions using either unused bit in mode filed or reserved fileds.

> 
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
> Regards
> Harald Mommer
> 
> 

Thank you so much again.

Best Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

