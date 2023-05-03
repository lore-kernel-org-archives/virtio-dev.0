Return-Path: <virtio-dev-return-12511-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EECC77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:50:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E5729603E8
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:50:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A33D986740
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:50:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D82649865A1; Wed,  3 May 2023 14:50:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 817BD986594;
	Wed,  3 May 2023 14:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVz4fKgzL6pAP3So2PvmL/AH/ss3bKeu6et+R6Gp1x6e7mQyClewEKiVoSUTqNSYWkxUrNzDCsIBuPdIFWI7Mn8Hq9kppN1z3UiJffFU6FZo4rsMjm6yDi346DUQak5UDSyIhvUfvn/IGzbSAxgCejFZyImbG+MINCFMkd20UHwrXm5X6W//dRKVAWJTHg3Hxbp7Xdvwu//JdSwVJC2nO8fiOwgmQa16pYhWiokJdJGrvR9UxCz0QcSQFSH2cCoRYkTKO/v3G1Bj1NrPyZDWCNg40nfLcqC2OkKta9AkuVnTF6iHTKjJ1qJiDqkR+oMb5kr0wsETm8t/mMTB73QKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD8mfGDQeBT4SeHnpy9Fdv9KEQPNKBLEmxw5jAd771g=;
 b=oU+DKeQWTL6afX7y8YHG1EQZkxzXDXkmTp3yx4PSQng8iHyFOkVLbaWumNuJ2Si5e8ZAbE52n5GlDC3SgXPisn5K8D0XdZCBY3mtY6DMzSPVEQqvmbibXV2ISZZLajaat+OVAeZ71ejwnl6KCjEfRZJaGo8Te1G9xSK7JmrpUNXvV9uFd1NBbV7+YOCCFSPyKBIHN9QatHZ6kCsk4vIX1VNIGY0E0U66kmX6C9iIVxI41fWPfoaXj0QtTrL9ktenCcZHqF2KsZTv+Z36ZlhMOSQ1tEh+tYELg8H3MVUqcUnZo2B8VdzJ01nRwkQ9tLaXijkZpk4oxPhDiQWk/b3Ldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <36e8746e-9edd-7998-3381-9cee2457f3df@nvidia.com>
Date: Wed, 3 May 2023 10:49:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503014838-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503014838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0174.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::23) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: c8997506-5d18-48f6-16f3-08db4be591f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fvikbe7zPSwhffnj9vCKzqunC4vmOWot0/Esuc//30ZAMzlf3bG1Fwmho+JipaEk0JpuPIrjonGWfsufONTT3cwnSVm/Sq9ZsFg2RRdJOPs3ECLbA3+7WlUvTOoEFezvgfLMTJvqJBSDvGkrTw4a/gR2HNdwjXKi+UXGYJ3ZKALRo7VowluYqBeWwhxMamONXQ4NNixO57EeLtpl6yfg84fFmCThrcpqt7LCAlkqa01QyT6hjtykW8V9q/R2/MGj2Ba6v5YiRFl6elGqVmHDBf4/hIMBIwT1r4h2CAzV2fZJiRVIXddsVhrPstx7iJl2In3dQzJSGZkuHNDGMoAyhs9Wu08KrMoRRo1mzGeZmcnmRMZp0hI7vzB2jG7DrVl0rSvHsYcXm+JmnpZfU8jnM6aaWnD3rrTo16bzz87w0urniZ7TUV4CZDRj4WQVf6/RqXr3bGDXypCxFO9RZGHAAA9+8znGEia+82aYA/1qZRQ5uUuDXP5F6XHHJ3sdtbkdaOZt9gDO/DQDmAAwLnboirOpdlDPy/JOj7yzCoHj4p8Tgo3yEgiZ0bl+Z4lf4O4uGI1CZBj0w8yMPpOLxggkj2GwkRT0ZddtiYTd9ATtNN1Q4A3UN597SoA5Hp7jUVrUhocQlJB6dRpBjbFTFYgDVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(6666004)(53546011)(26005)(6512007)(6506007)(107886003)(6486002)(316002)(66556008)(66476007)(2906002)(66946007)(8936002)(6916009)(5660300002)(31696002)(86362001)(4326008)(8676002)(31686004)(41300700001)(38100700002)(186003)(478600001)(2616005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWlNNkZxZEJHaFRMeXFvdVlyQjBvTm1YMFVxekdoTUx6U2dYRTZJN2lPY3h3?=
 =?utf-8?B?TVBLVlRCN3JKSTFYdWRDRFpJVXhXa2k3a0xuaDJHN0JwN0wzNHZLUXdPQzZN?=
 =?utf-8?B?N3lOQ3RNZFBCVDA3VW9yMTFzTFgrN0RjREZxK1FDazBqT2pxbHdKZTh0Z3d3?=
 =?utf-8?B?MjRPQmxOMzEyYllEcjB6YnlheTQ4ZG1kaWhXMytaT0tHejhjNWIxaUo0UnVH?=
 =?utf-8?B?VTlmR29MSDVhQU5rbWlQRHgyOTFwTWpHeEcza2lvWDYrT2x5Z0RINGZVSzB3?=
 =?utf-8?B?UjM4aTU1b3JoVW5QYlg5bm9XYThrOHNwNGZYMEFCNnNmajNDS3lOREN5UGlx?=
 =?utf-8?B?UzQ2Z092MHQxbzhSanlpTWJKRlNlcnZJdDByM21kbm1RMHdFR1V0WjduS1do?=
 =?utf-8?B?ekZoOTFOTTB0S2l4bG50ZkxoSzdyWEhxNjFJdEIrRkRVVGhwN1dtek16NTFu?=
 =?utf-8?B?SGJ3bVl3bU8wUUdPZ1A3MnQ3VG9rVkE1aU5GTGx4Tk5WWTNPQjZla251RHN4?=
 =?utf-8?B?dS8zOVVCN3FLcUR4eXpKTko5dkd6VHIwQmJDN3ZhUFgxY2xrdmZ3dUN0a004?=
 =?utf-8?B?WGhmeTV0MzBua3FZVGRVZzFBN294TXVJaTN1MHVBbFBuaW85UTZONTNXNFY3?=
 =?utf-8?B?Mjh2OFNBZXd3RXI5Y280MG5UWUxPZjdEK01zOUhOU1hnWGllcDBGM3QvYkZh?=
 =?utf-8?B?LzFCYlgzbWd5VlBPZ2dFUkQ4NXMyZG1XbjFrUllqWk4yWjhueXFkNUZzM1BJ?=
 =?utf-8?B?ZnZFb2xvZ09lRDBsN1BmV0J6U0xJM0JFdTZENExXazlNcUhuNW45NlQ5RFB2?=
 =?utf-8?B?VUVJUDFGSCtWaFpKR051cWpzMDQ5REYyajltWmRmeG1od3lZQWNwVkQzYVow?=
 =?utf-8?B?bUVsUFk5TVVibkc3QWJIRXNVOXAzVWdPc2UzUG1ONlMwdFVKbmptaVN5YlJN?=
 =?utf-8?B?aXBrNXV3a25MSlI2VE16NUpKV05Xblh2MFlZQnJYaDNLR2pSNU43a1p6NXRw?=
 =?utf-8?B?N2hOVENKcTNYcUIvTHdYOFFPSUVXc28wZENlNU8yTnVmUWdqd2xIZ05qSklO?=
 =?utf-8?B?SHVWMlFvNTZJSDdzRkNkbGR4bjFNSndOSDgwTU9RdWNqYmZyR1Y5K2dJWkRX?=
 =?utf-8?B?S0gzL1VPdGdxOTRvQXlQSTB1NUR0Ni9raThib1p4ZytNS0xneE55Yzh6bXMz?=
 =?utf-8?B?MXlYQi8rdTZtS25yVW0ralY2YTZCSDV0Q2VsSWYrdCtCVTJCdnQ2eGp2amZr?=
 =?utf-8?B?K2NXSW9VSlc1dXVyci96dUNBTE04OEZZUGdvQkRyL1ZOM1VPalFiVkJQbXVm?=
 =?utf-8?B?ZHVjM3JpNGFzRDlTRGkrNmpGNTNjTVFpM0VqOXJMZ21PcEp5VzRVemdpcTBB?=
 =?utf-8?B?ZFAzL042d3NjclUwcStBOTdSN3NvR1pPam41cjc3V1M1a0ttUEJ4REdWS3ls?=
 =?utf-8?B?NkdIa3ZzOEp6djdMOWpmbUozcGhRZS9oYlEvTU9JcFdwVEZWQmx6VTNNN25y?=
 =?utf-8?B?KzlQNEx2ay9MVzNIdnN3cGVkd2FZSm5GR2JGRUd1UCtENzRabWZvSEt1eHRM?=
 =?utf-8?B?YmFBTFRNaEVaRE8vMUlVTklXUWhUbm1NU2x0T3Rac2JLNzVXNHJKeTdhd3JQ?=
 =?utf-8?B?QzFGaTkxL1lwZ3I0NjFzL1p5M253amNtWVQ0Wk1SL084Q002MmRWdjJ0SUdt?=
 =?utf-8?B?SCt0bUg1bEcxWlQyQnh0NnVidHJPMEpiMEFvOVh0dDVqRWZJRVlFM3hSdXlB?=
 =?utf-8?B?R2gvZStHVW1JbnlJd1NPbWFVb3JQLzNwRUtHYzczRXBwNEZZNVNUYlA5MW13?=
 =?utf-8?B?K2RlSUUvYVkvUkhxcnVyYmxuRkFSYnRBYUVLYS9VUzgrcnhIOTJTTXFvU0l2?=
 =?utf-8?B?L2VNWktHQWZDckxMWGxKSzhLaUI0alBlSlpsNVRvdk1BbFRpSHRaZE9ZWVM4?=
 =?utf-8?B?VGpPOU16TG5aSEhHSmtJYW1peEFKUDhUdDk3K2M1TEJ4VSs5UVlncmxpYnYy?=
 =?utf-8?B?UVlMaitTTXFkT0xPOTJtSlZOUTRyN0Jic3FROC9BV1V4cFV6K3FVQ2FXNGc1?=
 =?utf-8?B?Q2NRcEpjOXo1Ym5QajhEYlk5YjI2SlVxSEc4YWxhelBySE1JVWRHYlJ3WlFB?=
 =?utf-8?Q?8tnc2ZLlaIheJmQbspIV4EWMq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8997506-5d18-48f6-16f3-08db4be591f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:49:17.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUymo6ehRK5i1Louy8/BmSVXKgNK5AJnxODvM0/zIjIMNDhch+Lc7ciCAe644OO7ofhDCZ4cUOSAJ/dPlL0eDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands



On 5/3/2023 1:50 AM, Michael S. Tsirkin wrote:
> On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:

>> +Legacy registers write admin command follows \field{struct virtio_admin_cmd}.
>> +This command writes legacy registers of a member VF device. Driver should write
>> +appropriate register \field{size} depending on the width of the legacy
>> +common registers or device specific registers.
>> +Driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_WRITE.
>> +Driver sets \field{group_type} to 1 for VFs.
>> +Driver sets \field{group_member_id} to a valid VF number.
>> +
>> +The \field{command_specific_data} has following listed structure format:
>> +
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd_lreg_wr_data {
>> +	u8 offset; /* Starting byte offset of the register(s) to write */
>> +	u8 size; /* Number of bytes to write into the register. */
>> +	u8 register[];
> 
> And maybe add
> 	u8 reserved[]; /* structure padding to multiple of 8 bytes */
> 
>> +};
Thinking, what do we miss without the padding here?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

