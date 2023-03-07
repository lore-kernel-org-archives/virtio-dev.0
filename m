Return-Path: <virtio-dev-return-11468-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C67C678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:40:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 112BC2A82D
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:40:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B9399866EB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:40:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 012B29866CC; Tue,  7 Mar 2023 07:40:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E24139866C2;
	Tue,  7 Mar 2023 07:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k68+LWTgBnD5czwlxvtU4X2FqOxgqnG0G9dXHFlWifhPyO6iDwBMMOstua89SHmwxX3k8/cs4F1vOwyf0C/mVTx+2xH2efmX09SI/CR1nOW2GldeP+8x92ICgejC0TgoFXlpNzt2zSuhOolIni3R9tmFNslz5p/xXggJ+/hRR7FlQfG7gO1C0r4RqXDlOkAOn/2beCdH/mhvh/be0ZgctvEw0Gt29EsJuAIO+BSp2eA6BzduAtDD36dmo5devI1+fVAP3OeYYD8S1FyMml8gQBa5Y4/po8XEvkA54KI9fyPTKKzZh7wXhPLx+8fo/4izuLxAwzmhf29Stq/kwpjagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EbjbBt/1cingbFTuWKJzPUziBtoKulzzouLXFbazZw=;
 b=TB4yl/vJahtNcuYcY5jCu0kZqmu2YM2BiGqIj45YYdNsW0kLQqMbxFxUdn/pXthw5DaauQbYjHXgjARNcHXyzXlkpgnkCVpfwEj0wKfQLpToWgiFz/invSDoW6sY+Vcq5KDH8mnPwxjkV/MIdb+YpeO4ZJBeh9XucK6M6elkvVqCwWIf2kzGCqsKiPAUakQ4Kr6DQW9+d6c9aikwmY6s9khbBsp7Ku1SSigUFX7S74ln+rTp/pcgVdzTLnSrIDaGVY2hbkdlrgTMqgu4h3884/J9jRao2v+e/L2Sz6ZsCQC+H3HVp7syt6434nXmtKwlv3Folpo7Inw0I+qf3SoZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 08:40:04 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAbqVJKPO4q6u9DS@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
 <ZAXB44F3MS9CxIiK@nanopsycho>
 <20230306134451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306134451-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a10efb-f89e-4254-586d-08db1edf2cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mw/Lz4INlLGQTXX1p8zMjoV7LBcusfPpHtUBRbPfuFuXGMbbYUUU9iT7wX8ClxVtLGRXb/gSMzKkHbimSor0rn5fSHaulXmxwV7BTjS0dTCbc/Y4ge9oBKl1CjcBdSfP/D1A/Ynn8pLp9RXI3J33GBDBhKlFxlLGHmymIxmS3OR/fzmeuY48rerdMGRlcb5TRJRethbjlMdUnJcqujPBhWtN/OCGHHsD1QJhEw+6A1EBKbeJzJR+wNzMo01KKJ/K/ZhV9TIyiWkRucS5XRMhlDLKtyNhyPCFfATJJXSPAq301m1HFPZ3J3dyIxwq+ADDuDSFKhSgMhontJUgZQ4KlawTmeIbuVVRHbSkuTTi4JS8NShRl0k/edOpXeGPdlUgTnrwyo9jNfoW5aVQr+8QOuB5k2n39MB2cod5+Tp2kjozwz5bKd66x5+wnzfTbNQi0f1OjVWGiw0B432uPrI/l3BQWyKsVjCXnSppFYXholfFg3KOSCz5z4/U5X7zj3qHc4ahQa09/om7XFp9yP/IrK3bx34Ap1VNBvhmiSAGl8iReipbsAzAy04oANSpVCMpjL45yem0VmAzoSMfEseUSGEMWM6oP+R/NbkgorctKYjPhd+WYJge4vgA6UTnm1R1VeDplSYnOKyQcHDZMOM4GdAf1D1Bbn5lSx7fhUjlXKBQll2X5z7++A5/Xb8LzXdKfZZqCuaNycOvf7hqMawxw7M5adkpVsJG/giaztsVGZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(316002)(54906003)(478600001)(966005)(6486002)(7416002)(5660300002)(8936002)(2906002)(66556008)(66476007)(6916009)(66946007)(4326008)(8676002)(41300700001)(6666004)(6512007)(38100700002)(86362001)(6506007)(186003)(26005)(33716001)(9686003)(107886003)(83380400001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBqZAXJyXwuetn9euC+2V6RFU7Y8BCqnKfLw31dsUfvvjEY3VVAp2r5+aIOM?=
 =?us-ascii?Q?im3FFi+S1YyBDIDBuMyq0xT5njt/lRZxGMDQbuNV0VGBGbPSUkDo05X+q9ze?=
 =?us-ascii?Q?dyk/DI6VS/CREBDxnB+mE3JiJ4ttHqzAg1AHPopaoPlPx+mSXz7Rl40LnPrG?=
 =?us-ascii?Q?GyiRr2WyF6+sKiik8Ssx9JQjItVHHzRGz/Hn94LSJGjeKgKCk6Ky+q1vFS5d?=
 =?us-ascii?Q?zMYly31r+4lmX7cfqEEqfEKtQiIJ8ncjh0XEc8oskGAxgfz2WLYXlyLzl2/W?=
 =?us-ascii?Q?iUhW4NBkqujRrMYovZ6jCBPipzq5hcFx3c20HM32aT+9Y9MnEDrmZdRy6D8r?=
 =?us-ascii?Q?4WL9storJdH+Q840/5OTvAjDUVjuibdq4eIyuclf8Sn9QCAv53U7t+tkPz8i?=
 =?us-ascii?Q?CMaKmykJ2NhYWGv8Uy88490rp2aSJS7mUIJW2HHVji8RbynmR10dCj3EYXpd?=
 =?us-ascii?Q?/8M9aWRR9AqgvhNtj95j8RdZ+lNUex/QCU0kys3XJ9J/dXH93vLiIuTyYjsb?=
 =?us-ascii?Q?hd6T6PQdt4QcaMxtoGcoM9brENU43NpJNG57x/ZSV6IH5Ej8rXMXfZQ0EPdV?=
 =?us-ascii?Q?hghHWswfhGHrbkwLQkPjilFLId/6s/1j4jkFxg3kY2+6mu+7nWK6AW+CVcIX?=
 =?us-ascii?Q?nvk+CINeqP658y+LpQxgWBz+H/d7OoKIVKSP0ZJiC6wvJkH5WpdPe5+8dFDR?=
 =?us-ascii?Q?PtzOLeebF0pBi7/I2iy5d3Bbbi0vco0Q26r21HldIc6OV2FoUJe/5n7YpldT?=
 =?us-ascii?Q?zz5wq9HjjncXG+YrmGkJdUFY96kCbVIbVbZ9ZH4zlFQpRifK/ZCyKbxIq+6i?=
 =?us-ascii?Q?eMN6FlbDlVKP9786IUO/qXd7k12rEPx/PY0oc0b/tcqU7e7fhf5czaGkO8ge?=
 =?us-ascii?Q?+OXkV18Bi8/1E+kx+kfiXFaghggmICseIbYvlPJ71Ieic36K64GX36YlZUBJ?=
 =?us-ascii?Q?JEO3sT12tbjw8pJUAUngZ2LH7hJpofmYkO8pO6r39VhkYhIj2+bELXIaECeq?=
 =?us-ascii?Q?C1Uc+LraW4BrD/b4rC9Bom8vWlQ4i0yesoQCnjIllBmJmUQhqo5f8OsE/ckY?=
 =?us-ascii?Q?cUl4BUUroaHt1MwjDgVzkNGlIDk9Nd/HgxndpnXbTYRe2JMSPEyS2ZDVoHjF?=
 =?us-ascii?Q?2hzQHPQN6VwAm9cRCkH1jcKBGRoFs5Jv37ZsvcO7MZWn+BO4xNpI9WiC6Kdi?=
 =?us-ascii?Q?BO/qHLfZFfTmqoFNirDxIvXjJ6MaVTMxcU1HRYmS27PLaXgYIZEkpVtIBC2G?=
 =?us-ascii?Q?VockLYi7JtJHytJo2C2oU2lFut8KEaHnH3zW5anq2kjMM4w1GnN66Y5wh38Q?=
 =?us-ascii?Q?zh1I67oAjZQF0x5ILXD3wqFXNCvydny+iMEkGKoCA96kTLIpXngaDvmXcnuE?=
 =?us-ascii?Q?XlL3oDQjLhnFd489VY2uxEj66psX9VqMCsjqOUT1ih/g9v5RaQmu78L4sx6e?=
 =?us-ascii?Q?05S8iXytpuQ695eC8FBV90NZC/Er51FnoJHXyzwA4u5P9czq2FLJBAn8qoEI?=
 =?us-ascii?Q?r7nxLXgYnVOlBRuVseKSEug0ydvxxIB/J/iEHsLtOlSrVrLuZWJc2sxyimN5?=
 =?us-ascii?Q?KjGgnEBv/JN+jHrgsCW8+uqXsDh3tPKEEUlbgLKZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a10efb-f89e-4254-586d-08db1edf2cf4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:40:08.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXaaWVu5nVJg98ulRRCHcpIazLOwL1tE3hQaQr4WLlzWBJG/DlIxhWmMiBnMXPx+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 06/10] mmio:
 document ADMIN_VQ as reserved

Mon, Mar 06, 2023 at 07:46:09PM CET, mst@redhat.com wrote:
>On Mon, Mar 06, 2023 at 11:35:15AM +0100, Jiri Pirko wrote:
>> Well, lots of these things (if not majority) are customary, not
>> really written up anywhere in Linux kernel netdev world. It's most of
>> the time just a matter of convenience I would say. For example
>> splitted-up patch changelog. I do it, but most of the people don't (even
>> maintainers). From time to time during review, I request it as I don't
>> want to be lost in the changes. It is nice if the submitter tries to
>> make reviewer's life a bit easier :)
>
>True. With all this lore let's just agree netdev is not the easiest
>project to get started with, right?

No clue, I'm soaked in for too long already :)


>
>-- 
>MST
>
>
>This publicly archived list offers a means to provide input to the
>OASIS Virtual I/O Device (VIRTIO) TC.
>
>In order to verify user consent to the Feedback License terms and
>to minimize spam in the list archive, subscription is required
>before posting.
>
>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>List help: virtio-comment-help@lists.oasis-open.org
>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>Committee: https://www.oasis-open.org/committees/virtio/
>Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

