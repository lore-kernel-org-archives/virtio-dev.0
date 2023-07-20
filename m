Return-Path: <virtio-dev-return-13387-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE877C0015E
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 07:50:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E4B722B050
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 07:50:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA72298680E
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 07:50:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B1E029842EA; Thu, 20 Jul 2023 07:50:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9CE079867FE
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 07:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <bca0df0a-2111-1f2f-69a9-3a2ea08fd37a@quicinc.com>
Date: Thu, 20 Jul 2023 15:50:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>
CC: "quic_ztu@quicinc.com" <quic_ztu@quicinc.com>,
        Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-3-quic_haixcui@quicinc.com>
 <ae8892c5-5eb2-72c9-9b74-cde7162094a2@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <ae8892c5-5eb2-72c9-9b74-cde7162094a2@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jwmY4YOy1Rj_re7A5CHrpi6GO61ZzpJB
X-Proofpoint-ORIG-GUID: jwmY4YOy1Rj_re7A5CHrpi6GO61ZzpJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200064
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hi Harald Mommer,

     Thank you so much for all your helpful advice and info!

     I have updated the transfer request as follows:

     struct spi_transfer_head {
           u8 slave_id;
           u8 bits_per_word;
           u8 cs_change;
           u8 tx_nbits;
           u8 rx_nbits;
           u8 reserved[3];
           u32 len;
           u32 mode;
           u32 freq;
           u32 word_delay_ns;
           u32 cs_setup_ns;
           u32 cs_delay_hold_ns;
           u32 cs_change_delay_inactive_ns;
     };

     struct spi_transfer_end {
           u8 result;
     };

     struct virtio_spi_transfer_req {
         struct spi_transfer_head head;
         u8 rx_buf[];
         u8 tx_buf[];
         struct spi_end end;
     };


     Also I add the member and field definition as follows:

     @slave_id: chipselect index the SPI transfer used.

     @bits_per_word: the number of bits in each SPI transfer word.

     @cs_change: whether to deselect device after finishing this transfer
         before starting the next transfer, 0 means cs keep asserted and
         1 means cs deasserted then asserted again.

     @tx_nbits: bus width for write transfer.
         0,1: bus width is 1, also known as SINGLE
         2  : bus width is 2, also known as DUAL
         4  : bus width is 4, also known as QUAD
         8  : bus width is 8, also known as OCTAL
         other values are invalid.

     @rx_nbits: bus width for read transfer.
         0,1: bus width is 1, also known as SINGLE
         2  : bus width is 2, also known as DUAL
         4  : bus width is 4, also known as QUAD
         8  : bus width is 8, also known as OCTAL
         other values are invalid.

     @reserved: for future use.

     @len: transfer length.

     @mode: SPI transfer mode.
         bit 0: CPHA, determines the timing (i.e. phase) of the data
             bits relative to the clock pulses.For CPHA=0, the
             "out" side changes the data on the trailing edge of the
             preceding clock cycle, while the "in" side captures the data
             on (or shortly after) the leading edge of the clock cycle.
             For CPHA=1, the "out" side changes the data on the leading
             edge of the current clock cycle, while the "in" side
             captures the data on (or shortly after) the trailing edge of
             the clock cycle.
         bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
             clock which idles at 0, and each cycle consists of a pulse
             of 1. CPOL=1 is a clock which idles at 1, and each cycle
             consists of a pulse of 0.
         bit 2: CS_HIGH, if 1, chip select active high, else active low.
         bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
             first, else LSB first.
         bit 4: LOOP, loopback mode.

     @freq: the transfer speed in Hz.

     @word_delay_ns: delay to be inserted between consecutive words of a
         transfer, in ns unit.
     @cs_setup_ns: delay to be introduced after CS is asserted, in ns
         unit.
     @cs_delay_hold_ns: delay to be introduced before CS is deasserted
         for each transfer, in ns unit.
     @cs_change_delay_inactive_ns: delay to be introduced after CS is
         deasserted and before next asserted, in ns unit.


     Could you please help review the transfer request above again to 
check if the interface is clear and enough for back-end to perform SPI 
transfers. Thank you again for your comments.


Best Regards
Haixu Cui

On 7/19/2023 2:25 AM, Harald Mommer wrote:
> Hello,
> 
> I've some comments on the draft specification. Looks promising but
> pointers in structures used to exchange information between driver and
> device are a no go. And there are some things which need to be (better)
> defined and clarified to implement an SPI device or driver from this
> draft specification.
> 
> On 17.04.23 16:03, Haixu Cui wrote:
>> virtio-spi is a virtual SPI master and it allows a guset to operate and
>> use the physical SPI master controlled by the host.
>> ---
>>    device-types/spi/description.tex        | 155 ++++++++++++++++++++++++
>>    device-types/spi/device-conformance.tex |   7 ++
>>    device-types/spi/driver-conformance.tex |   7 ++
>>    3 files changed, 169 insertions(+)
>>    create mode 100644 device-types/spi/description.tex
>>    create mode 100644 device-types/spi/device-conformance.tex
>>    create mode 100644 device-types/spi/driver-conformance.tex
>>
>> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..a68e5f4
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,155 @@
>> +\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
>> +
>> +virtio-spi is a virtual SPI(Serial Peripheral Interface) master and it allows a
>> +guest to operate and use the physical SPI master devices controlled by the host.
>> +By attaching the host SPI controlled nodes to the virtual SPI master device, the
>> +guest can communicate with them without changing or adding extra drivers for these
>> +controlled SPI devices.
>> +
>> +In a typical host and guest architecture with Virtio SPI, Virtio SPI driver
>> +is the front-end and exists in the guest kernel, Virtio SPI device acts as
>> +the back-end and exists in the host. And VirtQueue is used for communication
>> +between the front-end and the back-end.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / SPI Master Device / Device ID}
>> +45
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / SPI Master Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] requestq
>> +\end{description}
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / SPI Master Device / Feature bits}
>> +
>> +None.
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / SPI Master Device / Device configuration layout}
>> +
>> +All fields of this configuration are always available and read-only for the Virtio SPI driver.
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_config {
>> +    u32 bus_num;
>> +    u32 chip_select_max_number;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +\item[\field{bus_num}] is the physical spi master assigned to guset, and this is SOC-specific.
>> +
>> +\item[\field{chip_select_max_number}] is the number of chipselect the physical spi master supported.
>> +\end{description}
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / SPI Master Device / Device Initialization}
>> +
>> +\begin{itemize}
>> +\item The Virtio SPI driver configures and initializes the virtqueue.
>> +
>> +\item The Virtio SPI driver allocates and registers the virtual SPI master.
>> +\end{itemize}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / SPI Master Device / Device Operation}
>> +
>> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Master Device / Device Operation: Request Queue}
>> +
>> +The Virtio SPI driver queues requests to the virtqueue, and they are used by the
>> +Virtio SPI device. Each request represents one SPI transfer and it is of the form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_head {
>> +    u32 mode;
>> +    u32 freq;
>> +    u32 word_delay;
>> +    u8 slave_id;
>> +    u8 bits_per_word;
>> +    u8 cs_change;
>> +    u8 reserved;
>> +};
>
> Hunting for some length information of tx_buf and rx_buf.
> 
> The driver provides the device readable and the device writable buffers.
> 
> So for half duplex write the length of tx_buf is the total length of the
> device readable descriptors - transfer head.
> 
> So for half duplex read the length of rx_buf is the total length of the
> device writable descriptors - transfer end.
> 
> if (total size of device readable descriptors == transfer head) => half
> duplex read
> 
> if (total size of device writable descriptors == transfer end) => half
> duplex write
> 
> otherwise it's full duplex
> 
> The "mode" field seems to be foreseen to determine "half duplex read",
> "half duplex write" or "full duplex". So the "mode" field is redundant
> information but this is really no issue.
> 
> I think I got it now how to get the length information for all the
> possible transfers without having any buffer length information in the
> transfer head. Tricky. Should really be elaborated in the specification,
> took me hours to get it and I'm not convinced yet it's that. Initially I
> thought the length information in the transfer head was simply missing
> but most probably it is indeed not because the information can be
> obtained in a different way from the virtqueues.

Yes, in our current design, back-end can parse the transfer length from 
the received virtqueue descriptor, without transfer length information 
involved in the transfer request. Even so, I think it is necessary to 
add the length information to make the transfer request more clear.
> 
> What to send for half duplex read? Is it don't care or 0xFF, 0x00 or
> something else which needs to be determinable? In the past I had to use
> SPI always full duplex on the small controllers I worked with so the
> question did not arise.

For half duplex read, we send virtio_spi_req->head, 
virtio_spi_req->rx_buf, virtio_spi_req->end in order. It doesn't need to 
send the tx_buf.

For half duplex write, send virtio_spi_req->head, 
virtio_spi_req->tx_buf, virtio_spi_req->end in order.

For full duplex, send virtio_spi_req->head, virtio_spi_req->rx_buf, 
virtio_spi_req->tx_buf, virtio_spi_req->end in order.

> 
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_end {
>> +    u8 status; // Device=>Driver, device writable
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_spi_req {
>> +    struct virtio_spi_transfer_head head; // Driver=>Device, device readable
>> +    u8 *rx_buf; // Device=>Driver, device writable
>> +    u8 *tx_buf; // Driver=>Device, device readable
> 
> Won't work 1:
> 
> "2.7.4.2 Driver Requirements: Message Framing
> The driver MUST place any device­-writable descriptor elements after any
> device­-readable descriptor ele­ments."
> 
> => First tx_buf and afterwards rx_buf. The elements need to be exchanged.
> 
> Won't work 2:
> 
> You cannot send pointers around in virtio. A pointer in the virtual
> address space of the device has no meaning in the virtual address space
> of the driver and vice versa. And what's a pointer? Is it 32 bit or 64
> bit? Casting to le64 won't help also. You need to have buffers of
> sufficient size instead of the pointers in the structure.
> 
> Compare this with struct virtio_i2c_req from the I2C chapter:
> 
> u8 buf[];
> 
> This is a buffer of sufficient size, not a pointer. As there is only 1
> device writable descriptor (struct virtio_i2c_in_hdr) we have there also
> no issue finding the status. Different here. We have tx_buf in front of
> the status and we don't know how long this is.
> 
> The buf[] length in I2C may be obtained by the device from the bytes
> written by the driver to the virtqueue (need to check again) so no issue
> for I2C as they seem not to have a dedicated length information in their
> message structures.
> 
> =>
> 
> u8 tx_buf[];
> 
> u8 rx_buf[];
> 
OK, I will update it.

>> +    struct virtio_spi_transfer_end end;
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{mode} defines the SPI transfer mode.
> 
> Difficult. Your enumeration below looks like a enumeration in the text
> and not like the definition of values. Better is to clearly define the
> values.
> 
> #define VIRTIO_SPI_MODE_XXX 1 /* or whatever */
> 
> #define VIRTIO_SPI_MODE_YYY 2 /* or whatever */
> 
> #define VIRTIO_SPI_MODE_ZZZ 3 /* or whatever */
> 

mode here is the same as the mode filed in spi_device structure, in this 
file, bit0 (CPHA) and bit1 (CPOL) are the most important, indicate the 
clock phase and clock polarity respectively.

I will add the definition and meaning of each bit of mode in this 
specification.

>> +
>> +The \field{freq} defines the SPI transfer speed in Hz.
>> +
>> +The \field{word_delay} defines how long to wait between words within one SPI transfer,
>> +in ns unit.
>> +
>> +The \field{slave_id} defines the chipselect index the SPI transfer used.
>> +
>> +The \field{bits_per_word} defines the number of bits in each SPI transfer word.
>> +
>> +The \field{cs_change} defines whether to deselect device before starting the next SPI transfer.
> Most probably 0 is "don't deselect" and 1 is "deselect". Better define
> this clearly.

Exactly! I will add it.
>> +
>> +The \field{rx_buf} is the receive buffer, used to hold the data received from the external device.
>> +
>> +The \field{tx_buf} is the transmit buffer, used to hold the data sent to the external device.
>> +
>> +The final \field{status} byte of the request is written by the Virtio SPI device: either
>> +VIRTIO_SPI_MSG_OK for success or VIRTIO_SPI_MSG_ERR for error.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_SPI_MSG_OK     0
>> +#define VIRTIO_SPI_MSG_ERR    1
>> +\end{lstlisting}
>> +
>> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Master Device / Device Operation: Operation Status}
>> +
>> +Members in \field{struct virtio_spi_transfer_head} are determined by the Virtio SPI driver, while \field{status}
>> +in \field{struct virtio_spi_transfer_end} is determined by the processing of the Virtio SPI device.
> "determined" = "written" or "filled"? Below you use "filled". Beware
> English is not my native language but at least in the translation to
> German "determined" becomes ambiguous so it may be indeed ambiguous.

Yeah! "filled" seems better.
Well, "determined", a little strange

>> +
>> +Virtio SPI supports three transfer types: 1) half-duplex read, 2) half-duplex write, 3) full-duplex read and write.
>> +For half-duplex read transfer, \field{rx_buf} is filled by the Virtio SPI device and consumed by the Virtio SPI driver.
>> +For half-duplex write transfer, \field{tx_buf} is filled by the Virtio SPI driver and consumed by the Virtio SPI device.
>> +And for full-duplex read and write transfer, both \field{tx_buf} and \field{rx_buf} are used.
> The "transfer mode" above has become a "transfer type" here.

"transfer mode" reflects the mode filed in spi_device structure, which 
defines the clock phase, clock polarity and so on. This filed is not 
constant, for example it can be changed by calling ioctl with 
SPI_IOC_WR_MODE arguments, so it should be passed to the back-end to 
avoid using the expired mode.

I will add the definition of each bit of mode later.

"transfer type" here means the half duplex or full duplex.

>> +
>> +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
>> +
>> +The Virtio SPI driver MUST send messages on the requestq virtqueue.
>> +
>> +The \field{struct spi_transfer_head} MUST be filled by the Virtio SPI driver
>> +and MUST be readable for the Virtio SPI device.
>> +
>> +The \field{struct spi_transfer_end} MUST be filled by the Virtio SPI device
>> +and MUST be writable for the Virtio SPI device.
> 
> Isn't it obvious that the parts which MUST be written by side X must be
> readable by side Y? Nothing wrong here.
> 
> However this here is under the headline of "drivernormative" and I see a
> "MUST be filled by the Virtio SPI device" which is a requirement for the
> device.

OK, I will remove the device operation to the "devicenormative".
> 
>> +
>> +For half-duplex read, the Virtio SPI driver MUST send \field{struct spi_transfer_head},
>> +\field{rx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
>> +
>> +For half-duplex write, the Virtio SPI driver MUST send \field{struct spi_transfer_head},
>> +\field{tx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
>> +
>> +For full-duplex read and write, the Virtio SPI driver MUST send \field{struct spi_transfer_head},
>> +\field{rx_buf}, \field{tx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
>> +
>> +For half-duplex write or full-duplex read and write, the Virtio SPI driver MUST not use
>> +\field{rx_buf} if the final \field{status} returned from the Virtio SPI device is VIRTIO_SPI_MSG_ERR.
>> +
>> +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
>> +
>> +The Virtio SPI device MUST set all the fields of the \field{struct virtio_spi_config} on
>> +receiving a configuration request from the Virtio SPI driver.
>> +
>> +The Virtio SPI device MUST set the \field{struct spi_transfer_end} before sending it
>> +back to the Virtio SPI driver.
>> +
>> +The Virtio SPI device MUST be able to identify the transfer type according to the
>> +received VirtQueue descriptors.
> 
> Having difficulties. "Type" is "Mode"? By reading the "mode" field? This
> would be the trivial meaning of the sentence.

As mentioned before, type and mode are different in this specification.
> 
> Or is there a more deep meaning of "according to the received VirtQueue
> descriptors"?
> 
> If the length information of tx_buf and rx_buf are indeed not missing in
> the transfer head structure it would be probably good to elaborate on
> obtaining the length information here.
> 

Obtaining the length information relys on the back-end which will add 
extra requirement to the back-end. I think it is better to have length 
information involved.

>> +
>> +The Virtio SPI device MUST NOT change the value of the send buffer if transfer type
>> +is half-duplex write or full-duplex read and write.
>> diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
>> new file mode 100644
>> index 0000000..b9dea91
>> --- /dev/null
>> +++ b/device-types/spi/device-conformance.tex
>> @@ -0,0 +1,7 @@
>> +\conformance{\subsection}{SPI Master Device Conformance}\label{sec:Conformance / Device Conformance / SPI Master Device Conformance}
>> +
>> +A SPI Master device MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / SPI Master Device / Device Operation}
>> +\end{itemize}
>> diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
>> new file mode 100644
>> index 0000000..719b42e
>> --- /dev/null
>> +++ b/device-types/spi/driver-conformance.tex
>> @@ -0,0 +1,7 @@
>> +\conformance{\subsection}{SPI Master Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Master Driver Conformance}
>> +
>> +A SPI Master driver MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{drivernormative:Device Types / SPI Master Device / Device Operation}
>> +\end{itemize}
> 
> Regards
> Harald Mommer
> 
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

